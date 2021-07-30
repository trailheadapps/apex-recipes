/**
 * @description Class wraps DML Calls in FLS / Crud checks. Library is baseed on
 * a fluent api system. All calls are constructed, then chained with options.
 * For instances. `new Safely().allOrNothing().doInsert(List<sObject>);`
 *
 * Notable chainable methods include:
 * - allOrNothing() - this enforces the AllOrNothing DML flag. All DML is
 *      eventually executed via Database.* methods which accept an allOrNothing
 *      parameter requiring all of the records to succeed or fail.
 * - throwIfRemovedFields() - this method, if called, will result in an
 *     exception being thrown if any record being modified has fields removed
 *     by the security decision.
 */
public with sharing class Safely {
    @testVisible
    private Boolean allOrNothing = false;
    @testVisible
    private Boolean throwIfRemovedFields = false;

    public class RemovedFieldsException extends Exception {
    }

    public Safely allOrNothing() {
        this.allOrNothing = true;
        return this;
    }

    public Safely throwIfRemovedFields() {
        this.throwIfRemovedFields = true;
        return this;
    }

    /// Insert
    public List<Database.SaveResult> doInsert(List<SObject> records) {
        if (records.isEmpty()) {
            return new List<Database.SaveResult>();
        }
        if (CanTheUser.create(records)) {
            return doDML(System.AccessType.CREATABLE, records);
        }
        return new List<Database.SaveResult>();
    }

    public List<Database.SaveResult> doInsert(SObject record) {
        return doInsert(new List<Sobject>{ record });
    }

    /// Update
    public List<Database.SaveResult> doUpdate(List<SObject> records) {
        if (records.isEmpty()) {
            return new List<Database.SaveResult>();
        }
        if (CanTheUser.edit(records)) {
            return doDML(System.AccessType.UPDATABLE, records);
        }
        return new List<Database.SaveResult>();
    }

    public List<Database.SaveResult> doUpdate(SObject record) {
        return doUpdate(new List<Sobject>{ record });
    }

    /// Upsert
    public List<Database.UpsertResult> doUpsert(List<SObject> records) {
        if (records.isEmpty()) {
            return new List<Database.UpsertResult>();
        }
        if (CanTheUser.edit(records) && CanTheUser.create(records)) {
            SObjectAccessDecision securityDecision = guardAgainstRemovedFields(
                AccessType.UPSERTABLE,
                records
            );

            return Database.upsert(
                securityDecision.getRecords(),
                this.allOrNothing
            );
        }
        return new List<Database.UpsertResult>();
    }

    public List<Database.UpsertResult> doUpsert(Sobject record) {
        return doUpsert(new List<Sobject>{ record });
    }

    /// Delete
    public List<Database.DeleteResult> doDelete(List<SObject> records) {
        if (records.isEmpty()) {
            return new List<Database.DeleteResult>();
        }
        if (CanTheUser.destroy(records)) {
            return Database.delete(records, this.allOrNothing);
        }
        return new List<Database.DeleteResult>();
    }

    public List<Database.DeleteResult> doDelete(SObject record) {
        return doDelete(new List<Sobject>{ record });
    }

    /// Query - AKA Read
    public List<SObject> doQuery(String query) {
        List<SObject> records = Database.query(query);
        SObjectAccessDecision securityDecision = guardAgainstRemovedFields(
            AccessType.READABLE,
            records
        );
        return securityDecision.getRecords();
    }

    /// Private Methods
    private List<Database.SaveResult> doDML(
        System.AccessType accessType,
        List<SObject> records
    ) {
        SObjectAccessDecision securityDecision = guardAgainstRemovedFields(
            accessType,
            records
        );

        switch on accessType {
            when CREATABLE {
                return Database.insert(
                    securityDecision.getRecords(),
                    this.allOrNothing
                );
            }
            when UPDATABLE {
                return Database.update(
                    securityDecision.getRecords(),
                    this.allOrNothing
                );
            }
            // impossible, but required by compiler
            when else {
                return new List<Database.SaveResult>();
            }
        }
    }

    private SObjectAccessDecision guardAgainstRemovedFields(
        System.AccessType accessType,
        List<SObject> records
    ) {
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
            accessType, // What kind of Access are we checking?
            records, // The records to check
            true // <- true here also enforces CRUD.
        );
        Map<String, Set<String>> removedFields = securityDecision.getRemovedFields();
        if (this.throwIfRemovedFields && !removedFields.isEmpty()) {
            throw new RemovedFieldsException(
                'ThrowIfRemovedFields is enabled and the following fields were removed: ' +
                removedFields
            );
        }
        return securityDecision;
    }
}
