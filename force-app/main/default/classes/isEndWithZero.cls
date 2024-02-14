public class isEndWithZero {
    
    public static Boolean isEndWithZeroCheck(Integer num){
    // code here
    String numAsString = String.valueOf(num);
    
    if (numAsString.endsWith('0')) {
        return true;
    } else {
        return false;
    }

}

}