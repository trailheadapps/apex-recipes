/**
 * @description An opinionated trigger handler framework.
 * Originally by Kevin O'Hara github.com/kevinohara80/sfdc-trigger-framework
 * @group Shared Code
 * @see AccountTriggerHandler
 * @see PlatformEventRecipesTriggerHandler
 */
public virtual class TriggerHandler {
    // static map of handlername, times run() was invoked
    private static Map<String, LoopCount> loopCountMap;
    private static Set<String> bypassedHandlers;

    // the current context of the trigger, overridable in tests
    @testVisible
    protected TriggerContext context;

    // the current context of the trigger, overridable in tests
    @testVisible
    private Boolean isTriggerExecuting;

    // static initialization
    static {
        loopCountMap = new Map<String, LoopCount>();
        bypassedHandlers = new Set<String>();
    }
    /**
     * @description Internal TriggerHandler custom exception class
     */
    public class TriggerHandlerException extends Exception {
    }

    /**
     * @description Constructs a trigger handler object and ensures the context
     * is set
     */
    public TriggerHandler() {
        this.setTriggerContext();
    }

    /**
     * @description This is main brokering method that is called by the trigger.
     * It's responsible for determining the proper context, and calling the
     * correct method
     * @example
     * ```
     * AccountTriggerHandler.run();
     * ```
     */
    public virtual void run() {
        if (!validateRun()) {
            return;
        }

        addToLoopCount();

        // dispatch to the correct handler method
        switch on context {
            when BEFORE_INSERT {
                this.beforeInsert();
            }
            when BEFORE_UPDATE {
                this.beforeUpdate();
            }
            when AFTER_INSERT {
                this.afterInsert();
            }
            when AFTER_UPDATE {
                this.afterUpdate();
            }
            when BEFORE_DELETE {
                this.beforeDelete();
            }
            when AFTER_DELETE {
                this.afterDelete();
            }
            when AFTER_UNDELETE {
                this.afterUndelete();
            }
        }
    }

    /**
     * @description Allows developers to prevent trigger loops, or allow
     * a limited number of them by setting the maximum number of times
     * this trigger is called.
     * @param max   A valid number (generally 1) of times you'd like
     * to allow the trigger to run.
     * @example
     * In the context of a `TriggerHandler` class:
     * ```
     * this.setMaxLoopCount(5);
     * ```
     */
    public void setMaxLoopCount(Integer max) {
        String handlerName = getHandlerName();
        if (!TriggerHandler.loopCountMap.containsKey(handlerName)) {
            TriggerHandler.loopCountMap.put(handlerName, new LoopCount(max));
        } else {
            TriggerHandler.loopCountMap.get(handlerName).setMax(max);
        }
    }

    /**
     * @description Allows developers to turn off the max loop count
     * @example
     * In the context of a `TriggerHandler` class:
     * ```
     * this.clearMaxLoopCount();
     * ```
     */
    public void clearMaxLoopCount() {
        this.setMaxLoopCount(-1);
    }

    /**
     * @description       Allows developers to conditionally bypass (disable)
     * other triggers that *also* implement this triggerHandler
     * @param handlerName Class name (String) of the trigger handler to bypass
     * @example
     * ```
     * TriggerHandler.bypass('AccountTriggerHandler');
     * ```
     */
    public static void bypass(String handlerName) {
        TriggerHandler.bypassedHandlers.add(handlerName);
    }

    /**
     * @description       Removes a given trigger handler class name from
     * the list of bypassed trigger handlers.
     * @param handlerName Handler class name to remove from the bypass list
     * @example
     * ```
     * TriggerHandler.clearBypass('AccountTriggerHandler');
     * ```
     */
    public static void clearBypass(String handlerName) {
        TriggerHandler.bypassedHandlers.remove(handlerName);
    }

    /**
     * @description       Allows developers to check whether a given trigger
     * handler class is currently bypassed.
     * @param handlerName The name of the trigger handler class to check for
     * @example
     * ```
     * TriggerHandler.isBypassed('AccountTriggerHandler');
     * ```
     */
    public static Boolean isBypassed(String handlerName) {
        return TriggerHandler.bypassedHandlers.contains(handlerName);
    }

    /**
     * @description removes all classes from the bypass list
     * @example
     * ```
     * Triggerhandler.clearAllBypasses();
     * ```
     */
    public static void clearAllBypasses() {
        TriggerHandler.bypassedHandlers.clear();
    }

    /***************************************
     * private instancemethods
     ***************************************/

    /**
     * @description internal method to forcibly set the trigger context
     */
    @testVisible
    private void setTriggerContext() {
        this.setTriggerContext(null, false);
    }

    /**
     * @description    Internal method for manually setting the trigger context
     * @param ctx      The current trigger Context
     * @param testMode Is the trigger running in a test context?
     */
    @testVisible
    private void setTriggerContext(String ctx, Boolean testMode) {
        if (!Trigger.isExecuting && !testMode) {
            this.isTriggerExecuting = false;
            return;
        } else {
            this.isTriggerExecuting = true;
        }

        if (Trigger.isExecuting && !testMode) {
            switch on Trigger.operationType {
                when BEFORE_INSERT {
                    context = TriggerContext.BEFORE_INSERT;
                }
                when BEFORE_UPDATE {
                    context = TriggerContext.BEFORE_UPDATE;
                }
                when BEFORE_DELETE {
                    context = TriggerContext.BEFORE_DELETE;
                }
                when AFTER_INSERT {
                    context = TriggerContext.AFTER_INSERT;
                }
                when AFTER_UPDATE {
                    context = TriggerContext.AFTER_UPDATE;
                }
                when AFTER_DELETE {
                    context = TriggerContext.AFTER_DELETE;
                }
                when AFTER_UNDELETE {
                    context = TriggerContext.AFTER_UNDELETE;
                }
            }
        } else if (ctx != null && testMode) {
            switch on ctx {
                when 'before insert' {
                    context = TriggerContext.BEFORE_INSERT;
                }
                when 'before update' {
                    context = TriggerContext.BEFORE_UPDATE;
                }
                when 'before delete' {
                    context = TriggerContext.BEFORE_DELETE;
                }
                when 'after insert' {
                    context = TriggerContext.AFTER_INSERT;
                }
                when 'after update' {
                    context = TriggerContext.AFTER_UPDATE;
                }
                when 'after delete' {
                    context = TriggerContext.AFTER_DELETE;
                }
                when 'after undelete' {
                    context = TriggerContext.AFTER_UNDELETE;
                }
                when else {
                    throw new TriggerHandler.TriggerHandlerException(
                        'Unexpected trigger context set'
                    );
                }
            }
        }
    }

    /**
     * @description increment the loop count
     * @exception   Throws loop count exception if the max loop count is reached
     */
    @testVisible
    protected void addToLoopCount() {
        String handlerName = getHandlerName();
        if (TriggerHandler.loopCountMap.containsKey(handlerName)) {
            Boolean exceeded = TriggerHandler.loopCountMap.get(handlerName)
                .increment();
            if (exceeded) {
                Integer max = TriggerHandler.loopCountMap.get(handlerName).max;
                throw new TriggerHandlerException(
                    'Maximum loop count of ' +
                        String.valueOf(max) +
                        ' reached in ' +
                        handlerName
                );
            }
        }
    }

    /**
     * @description make sure this trigger should continue to run
     * @exception TriggerHandlerException thrown when executing outside of a
     * trigger
     */
    @testVisible
    protected Boolean validateRun() {
        if (!this.isTriggerExecuting || this.context == null) {
            throw new TriggerHandlerException(
                'Trigger handler called outside of Trigger execution'
            );
        }
        if (TriggerHandler.bypassedHandlers.contains(getHandlerName())) {
            return false;
        }
        return true;
    }

    /**
     * @description Returns the string version of the handler class being
     * invoked
     * @return Name of the Handler
     */
    @testVisible
    private String getHandlerName() {
        return String.valueOf(this)
            .substring(0, String.valueOf(this).indexOf(':'));
    }

    /***************************************
     * context methods
     ***************************************/

    /**
     * These methods are all intended to be overridden by
     * individual trigger handlers. They exist here only to
     * establish the 'software contract' that they exist.
     */

    /**
     * @description Virtual method for the implementing class to override
     */
    @testVisible
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void beforeInsert() {
    }
    /**
     * @description Virtual method for the implementing class to override
     */
    @testVisible
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void beforeUpdate() {
    }
    /**
     * @description Virtual method for the implementing class to override
     */
    @testVisible
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void beforeDelete() {
    }
    /**
     * @description Virtual method for the implementing class to override
     */
    @testVisible
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void afterInsert() {
    }
    /**
     * @description Virtual method for the implementing class to override
     */
    @testVisible
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void afterUpdate() {
    }
    /**
     * @description Virtual method for the implementing class to override
     */
    @testVisible
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void afterDelete() {
    }
    /**
     * @description Virtual method for the implementing class to override
     */
    @testVisible
    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void afterUndelete() {
    }

    /***************************************
     * inner classes
     ***************************************/

    /**
     * @description inner class for managing the loop count per handler
     */
    @testVisible
    private class LoopCount {
        private Integer max;
        private Integer count;

        /**
         * @description Loop counter method with default of 5.
         */
        public LoopCount() {
            this.max = 5;
            this.count = 0;
        }

        /**
         * @description Sets loop count based on the param.
         * @param max   Maximum number of loops to allow.
         */
        public LoopCount(Integer max) {
            this.max = max;
            this.count = 0;
        }

        /**
         * @description Increment the internal counter returning the results of
         * this.exceeded().
         * @return true if count will exceed max count or is less
         * than 0.
         */
        public Boolean increment() {
            this.count++;
            return this.exceeded();
        }

        /**
         * @description Determines if this we're about to exceed the loop count.
         * @return true if less than 0 or more than max.
         */
        public Boolean exceeded() {
            if (this.max < 0) {
                return false;
            }
            if (this.count > this.max) {
                return true;
            }
            return false;
        }

        /**
         * @description Returns the max loop count.
         * @return max loop count.
         */
        public Integer getMax() {
            return this.max;
        }

        /**
         * @description Returns the current loop count.
         * @return current loop count.
         */
        public Integer getCount() {
            return this.count;
        }

        /**
         * @description Sets the max loop size
         * @param max   The integer to set max to.
         */
        public void setMax(Integer max) {
            this.max = max;
        }
    }

    /**
     * @description possible trigger contexts
     */
    @testVisible
    public enum TriggerContext {
        BEFORE_INSERT,
        BEFORE_UPDATE,
        BEFORE_DELETE,
        AFTER_INSERT,
        AFTER_UPDATE,
        AFTER_DELETE,
        AFTER_UNDELETE
    }
}
