public class CheckOddorEven {
    
 public static String evenOrOdd(Integer num) {
  if (Math.mod(num, 2) == 0) {
            return 'even';
        } else {
            return 'odd';
        }
}
}