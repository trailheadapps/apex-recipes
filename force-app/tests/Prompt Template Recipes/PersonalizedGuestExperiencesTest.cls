@IsTest
private class PersonalizedGuestExperiencesTest {
    @IsTest
    static void responseEmptyWhenNoSessions() {
        // GIVEN
        Contact ctc = new Contact(FirstName = 'Robert', LastName = 'Chang');
        insert ctc;

        PersonalizedGuestExperiences.Request request = new PersonalizedGuestExperiences.Request();
        request.myContact = ctc;

        // WHEN
        Test.startTest();
        List<PersonalizedGuestExperiences.Response> responses = PersonalizedGuestExperiences.getSessions(
            new List<PersonalizedGuestExperiences.Request>{ request }
        );
        Test.stopTest();

        // THEN
        Assert.areEqual(
            '[]',
            responses[0].Prompt,
            'Expected empty response as there are no sessions that match'
        );
    }
}
