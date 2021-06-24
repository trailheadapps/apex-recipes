/**
 * @description  This class is a data-model class. It represents a `Secret` -
 * a piece of information that is:
 * * encrypted at rest.
 * * deployable.
 * * useless without metadata that cannot be deployed.
 *
 * Functionally, the Secrets family of recipes separate the encrypted data and
 * the decryption keys into two different storage mediums. Secrets themselves
 * are stored in Custom Metadata. Keys, however, are stored in Custom Settings.
 * Because custom settings are not deployable, the secrets records themselves
 * are safe to be committed to SCM.
 *
 * @group Secrets Recipes
 * @see Secrets
 */
public class SecretsData {
    // The `name` property is how we identify and reference secrets.
    public String name { get; set; }
    // The key name specifies which key was used to encrypt this secret.
    public String keyName { get; set; }
    // This holds the current encrypted string
    public String encryptedValue { get; set; }
    // This holds the current clearText string
    public String clearTextValue { get; set; }
}
