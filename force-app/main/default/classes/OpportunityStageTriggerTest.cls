@IsTest
public class OpportunityStageTriggerTest {

    @IsTest
    static void testInvalidStageProbability() {
        // Arrange
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            Probability = 90,
            CloseDate = Date.today().addDays(10)
        );

        // Act
        Test.startTest();
        try {
            insert opp;
            System.assert(false, 'Exception expected but not thrown');
        } catch (Exception e) {
            // Assert
            System.assert(
                e.getMessage().contains('Probability'),
                'Expected validation exception message'
            );
        }
        Test.stopTest();
    }
}
