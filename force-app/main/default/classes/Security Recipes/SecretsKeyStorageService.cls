/**
 * @description This interface defines the required methods for a class to
 * implement so that it can function as a SecretsKeyStorageService.
 * @group Secrets Recipes
 * @see Secrets, SecretsKeyServiceCustomSettings
 */
public interface SecretsKeyStorageService {
    Blob getKey(String keyName);
    Boolean createKey(String keyName, Integer keySize);
}
