public interface SecretsKeyStorageService {
    Blob getKey(String keyName);
    Boolean createKey(String keyName, Integer keySize);
}