public class VaultEncrypt {

    public String request_id;
    public String lease_id;
    public Boolean renewable;
    public Integer lease_duration;
    public Data data;
    public Object wrap_info;
    public Object warnings;
    public Object auth;

    public class Data {
        public String ciphertext;
        public String plaintext;
        public Integer key_version;
    }

    
    public static VaultEncrypt parse(String json) {
        return (VaultEncrypt) System.JSON.deserialize(json, VaultEncrypt.class);
    }
}
