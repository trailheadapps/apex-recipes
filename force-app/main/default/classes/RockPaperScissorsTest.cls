@isTest
public class RockPaperScissorsTest {
    @isTest
    static void testResult(){
        
        integer result = RockPaperScissors.rockPaperScissors('rock','scissors');
        system.assertEquals(1,result,'Players won');
        
        integer result1 = RockPaperScissors.rockPaperScissors('rock','rock');
        system.assertEquals(0,result1,'Players Are same');

        integer result2 = RockPaperScissors.rockPaperScissors('scissors','paper');
        system.assertEquals(1,result2,'Players Won');    
        
        integer result3 = RockPaperScissors.rockPaperScissors('paper','rock');
        system.assertEquals(1,result3,'Players Won');
        
        integer result4 = RockPaperScissors.rockPaperScissors('paper','scissors');
        system.assertEquals(2,result4,'Players Lost');   
        
    }

}