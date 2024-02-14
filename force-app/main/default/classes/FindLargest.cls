public class FindLargest {
    public static Integer findLargestNum(Integer num1, Integer num2, Integer num3) {
    if (num1 >= num2 && num1 >= num3) {
        return num1;
    } else if (num2 >= num1 && num2 >= num3) {
        return num2;
    } else if (num3 >= num1 && num3 >= num2) {
        return num3;
    } else {
        return null;
    }
}
}