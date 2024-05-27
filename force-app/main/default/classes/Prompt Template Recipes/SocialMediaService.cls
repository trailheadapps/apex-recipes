public with sharing class SocialMediaService {
    public String generateSocialMediaPosts(
        String experienceInstanceId,
        ConnectApiWrapper connectApiInstance
    ) {
        // Create inputs
        Map<String, String> experienceInstance = new Map<String, String>();
        experienceInstance.put('id', experienceInstanceId);
        ConnectApi.WrappedValue experienceInstanceValue = new ConnectApi.WrappedValue();
        experienceInstanceValue.value = experienceInstance;
        Map<String, ConnectApi.WrappedValue> inputParams = new Map<String, ConnectApi.WrappedValue>();
        inputParams.put('Input:experienceInstance', experienceInstanceValue);

        // Configure invocation parameters
        ConnectApi.EinsteinPromptTemplateGenerationsInput executeTemplateInput = new ConnectApi.EinsteinPromptTemplateGenerationsInput();
        executeTemplateInput.additionalConfig = new ConnectApi.EinsteinLlmAdditionalConfigInput();
        executeTemplateInput.additionalConfig.applicationName = 'PromptBuilderPreview';
        executeTemplateInput.isPreview = false;
        executeTemplateInput.inputParams = inputParams;

        try {
            // Call the service
            ConnectApi.EinsteinPromptTemplateGenerationsRepresentation generationsOutput = connectApiInstance.generateMessagesForPromptTemplate(
                'Generate_Social_Media_Posts',
                executeTemplateInput
            );
            ConnectApi.EinsteinLLMGenerationItemOutput response = generationsOutput.generations[0];
            return response.text;
        } catch (Exception e) {
            System.debug(e.getMessage());
            throw e;
        }
    }
}
