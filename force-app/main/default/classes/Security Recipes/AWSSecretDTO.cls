/**
 * @description Data transfer object describing the AWS Secrets Manager payload
 * @group Secrets Recipes
 * @see Secrets, SecretsKeyServiceAWSSecretManager
 */
@suppressWarnings('PMD.FieldNamingConventions')
public with sharing class AWSSecretDTO {
    public String ARN;
	public Double CreatedDate;
	public String Name;
	public String SecretString;
	public String VersionId;
	public List<String> VersionStages;
    public String StringValue;

    public static AWSSecretDTO parse(String json) {
        AWSSecretDTO ret = (AWSSecretDTO) System.JSON.deserialize(json, AWSSecretDTO.class);
        ret.parseSecret();
        return ret;
    }

    public void parseSecret() {
        JSONParser parser = JSON.createParser(this.SecretString);
        // Advance to the start object marker.
        parser.nextToken();
        // Advance to the next value.
        parser.nextValue();
        // Get the String value.
        this.StringValue = parser.getText();
    }
}
