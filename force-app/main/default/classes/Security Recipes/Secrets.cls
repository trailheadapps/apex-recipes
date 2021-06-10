/**
 * @description A class to encrypt and decrypt (store and retrieve) secrets
 * where the encryption keys are stored as custom settings.
 * Note: Do not use this class, if you're simply storing a user/pass for an api
 * callout - use a named credential instead for that use case.
 */
public with sharing class Secrets {
    @TestVisible
    private SecretsStorageService storageService;

    public class SecretException extends Exception {
    }

    public Secrets(SecretsStorageService storageService) {
        this.storageService = storageService;
    }

    private Secrets() {
    }

    public SecretsData fetchSecret(String secretName) {
        return this.storageService.retrieve(
            secretName
        ); 
    }

    public Boolean createSecret(
        String secretName,
        String secretValue,
        String keyName
    ) {
        return this.storageService.store(keyName, secretName, secretValue);
    }

    public void updateSecret(SecretsData newValue) {
        this.storageService.store(newValue.keyName, newValue.name, newValue.clearTextValue);
    }

    public Boolean createKey(String keyName) {
        return this.storageService.createKey(keyName);
    }
}
