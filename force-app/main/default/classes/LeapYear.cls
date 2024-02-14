public class LeapYear {
    
    public static Boolean isLeapYear(Integer year) {
    //code here
    if ((Math.mod(year, 4) == 0) && (Math.mod(year, 100) != 0 || Math.mod(year, 400) == 0)) {
            return true; 
        } else {
            return false; 
        }

}

}