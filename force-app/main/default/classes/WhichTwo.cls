public class WhichTwo {
    public static String whichTwoCheck(Integer a, Integer b, Integer c) {
      // code here
    if (a + b == c) {
        return 'c';
    } else if (a + c == b) {
        return 'b';
    } else if (c + b == a) {
        return 'a';
    } else{
        return '';
    } 
}

}