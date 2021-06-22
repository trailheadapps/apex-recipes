/**
 * @description A class to encrypt and decrypt (store and retrieve) secrets
 * where the encryption keys are stored as custom settings.
 * Note: Do not use this class, if you're simply storing a user/pass for an api
 * callout - use a named credential instead for that use case.
 *
 * @group Secrets Recipes
 * @see Secrets
 */
public with sharing class Secrets {
    @TestVisible
    private SecretsStorageService storageService;

    /**
     * @description          Standard constructor - requires a Storage Service
     * instance.
     * @param storageService Any object conforming to the SecretsStorageService
     * interface
     */
    public Secrets(SecretsStorageService storageService) {
        this.storageService = storageService;
    }

    /**
     * @description      retrieves the named secret and returns an object with
     * the secret's properties.
     * @param secretName the string naming the secret
     * @return           `SecretsData`
     */
    public SecretsData fetchSecret(String secretName) {
        return this.storageService.retrieve(secretName);
    }

    /**
     * @description       Creates a net-new secret. Does not update.
     * @param secretName  Name of the secret to be created
     * @param secretValue Clear text of the secret's value - this will be
     * encrypted
     * @param keyName     Key to encrypt the secret with.
     * @return            `Boolean`
     */
    public Boolean createSecret(
        String secretName,
        String secretValue,
        String keyName
    ) {
        return this.storageService.store(keyName, secretName, secretValue);
    }

    /**
     * @description    Updates a secret, with the values of the newSecretsData
     * parameter
     * @param newSecretData The new version of the SecretsData to store.
     */
    public void updateSecret(SecretsData newSecretData) {
        this.storageService.store(
            newSecretData.keyName,
            newSecretData.name,
            newSecretData.clearTextValue
        );
    }

    /**
     * @description Creates a new Key to encrypt secrets with.
     * Note: keys are immutable and cannot be updated.
     */
    public Boolean createKey(String keyName) {
        return this.storageService.createKey(keyName);
    }
}
