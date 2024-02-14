public class DiffChecker {
    public static Integer diff(Integer a, Integer b) {
    integer difference;
        
        if(a>b)
        {
            difference = a - b ;
        }
        else
        {
            difference = b - a;
        }
        return difference;
}
}