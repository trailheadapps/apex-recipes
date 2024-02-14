public class RockPaperScissors {
    public static Integer rockPaperScissors(String player1, String player2) {
    //code here
  if (player1 == player2)
            return 0;
        else if ((player1 == 'rock' && player2 == 'scissors') ||
                 (player1 == 'scissors' && player2 == 'paper') ||
                 (player1 == 'paper' && player2 == 'rock') )
            return 1;
        else
            return 2;
}

}