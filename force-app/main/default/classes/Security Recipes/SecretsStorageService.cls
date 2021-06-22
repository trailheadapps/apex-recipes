/**
 * @description  Interface defining the methods SecretsStorageServices must
 * implement
 */
public interface SecretsStorageService {
    Boolean store(String keyName, string itemName, String clearText);
    SecretsData retrieve(string itemName);
    Boolean createKey(String keyName);
}
