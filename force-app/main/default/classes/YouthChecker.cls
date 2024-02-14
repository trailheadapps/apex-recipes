public class YouthChecker {
    public static String ageGroup(Integer n) {
    //code here
    if(n <= 1)
    return 'Infant';
    else if(n >= 2 && n <= 14)
    return 'Child';
    else if (n >= 15 && n <=21)
    return 'Youth';
    else
     return 'Adult';
}
}