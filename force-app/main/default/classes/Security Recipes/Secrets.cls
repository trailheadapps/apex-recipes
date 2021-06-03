/**
 * @description A class to encrypt and decrypt (store and retrieve) secrets
 * where the encryption keys are stored as custom settings.
 * Note: Do not use this class, if you're simply storing a user/pass for an api
 * callout - use a named credential instead for that use case.
 */
public with sharing class Secrets {
    @TestVisible
    private SecretsKeyService keyService = new SecretsKeyService();
    @TestVisible
    private SecretsStorageService storageService = new SecretsStorageService(
        keyService
    );
    public class Secret {
        @TestVisible
        private SecretsKeyService keyService;
        @TestVisible
        private SecretsStorageService storageService;
        public String name { get; private set; }
        public Blob key { get; set; }
        public String keyName { get; private set; }
        public String algorithm { get; private set; }
        public String hmacAlgorithmPayload { get; private set; }
        public Blob encodedEncryptedValue { get; private set; }
        public String hmacPayload { get; private set; }
        public String clearTextValue { get; private set; }

        @testVisible
        private Secret() {
        }

        public Secret(
            SecretsStorageService storageService,
            SecretsKeyService keyService,
            String name,
            List<String> secretData
        ) {
            this.storageService = storageService;
            this.keyService = keyService;
            this.name = name;
            hydrateSecret(secretData);
        }

        public Secret(
            SecretsStorageService storageService,
            SecretsKeyService keyService,
            String name,
            String serializedSecret
        ) {
            this.storageService = storageService;
            this.keyService = keyService;
            this.name = name;
            hydrateSecret(validateSecretFormat(serializedSecret));
        }

        public Secret(
            SecretsStorageService storageService,
            SecretsKeyService keyService,
            String name
        ) {
            this.storageService = storageService;
            this.keyService = keyService;
            this.name = name;
            SecretMDT__mdt secret = this.storageService.fetchExistingSecret(
                name
            );
            hydrateSecret(validateSecretFormat(secret.value__c));
        }

        public Secret(
            SecretsStorageService storageService,
            SecretsKeyService keyService,
            String name,
            String keyName,
            String clearTextValue
        ) {
            this.storageService = storageService;
            this.keyService = keyService;
            this.name = name;
            this.keyName = keyName;
            this.clearTextValue = clearTextValue;
        }

        public Void updateSecret() {
            this.storageService.storeSecret(this);
        }

        private Void hydrateSecret(List<String> secretData) {
            this.key = keyService.getKey(secretData[0]);
            this.algorithm = secretData[1];
            this.hmacAlgorithmPayload = secretData[2];
            this.encodedEncryptedValue = EncodingUtil.base64Decode(
                secretData[3]
            );
            this.hmacPayload = secretData[4];
        }

        private List<String> validateSecretFormat(String secretString) {
            // Ensure the secret value meets the required format of:
            // <ENCRYPTION KEY NAME>~<ENCRYPTION ALGORITHM>~<HMAC ALGORITHM>~<ENCRYPTED VALUE>~<HMAC VALUE>

            List<String> secretData = secretString.split('~');
            if (secretData.size() != 5) {
                throw new SecretException(
                    'Secret ' +
                    this.name +
                    'has invalid format'
                );
            }
            return secretData;
        }

        public String decryptSecret() {
            // Guard against a tampered with secret
            throwIfSecretHasBeenTamperedWith();
            Blob decryptedSecret = Crypto.decryptWithManagedIV(
                this.algorithm,
                this.key,
                this.encodedEncryptedValue
            );
            return decryptedSecret.toString();
        }

        private void throwIfSecretHasBeenTamperedWith() {
            // Verify that the data has not been tampred with by generating an HMAC of the encrypted data and comparing it to the HMAC of the payload.
            // HMAC generation uses the name of the secret as the key to ensure integrity.

            String hmac = EncodingUtil.base64Encode(
                crypto.generateMac(
                    this.hmacAlgorithmPayload,
                    this.encodedEncryptedValue,
                    Blob.valueOf(this.name)
                )
            );
            // Use a (relatively) time constant comparison operation to mitigate timing attacks
            if (!ConstantTimeCompare(hmac, hmacPayload)) {
                throw new SecretException(
                    'Secret ' +
                    this.name +
                    'has invalid HMAC'
                );
            }
        }

        // An approximate constant time comparison algorithm
        private Boolean constantTimeCompare(String first, String second) {
            Boolean result = true;
            if (first.length() != second.length()) {
                result = false;
            }
            Integer max = first.length() > second.length()
                ? second.length()
                : first.length();
            for (Integer i = 0; i < max; i++) {
                if (first.substring(i, i + 1) != second.substring(i, i + 1)) {
                    result = false;
                }
            }
            return result;
        }
    }

    public class SecretException extends Exception {
    }

    public Secrets(SecretsStorageService storageService) {
        this.storageService = storageService;
    }

    public Secrets() {
    }

    public Secrets.Secret fetchSecret(String secretName) {
        return new Secret(this.storageService, this.keyService, secretName);
    }

    public String fetchDecryptedSecretValue(String secretName) {
        return new Secret(this.storageService, this.keyService, secretName)
            .decryptSecret();
    }

    public Boolean createSecret(
        String secretName,
        String secretValue,
        String keyName
    ) {
        Secret newSecret = new Secret(
            this.storageService,
            this.keyService,
            secretName,
            keyName,
            secretValue
        );
        newSecret.storageService.storeSecret(newSecret);
        return true;
    }

    public Boolean createKey(String keyName) {
        return new SecretsKeyService().createKey(keyName);
    }
}
