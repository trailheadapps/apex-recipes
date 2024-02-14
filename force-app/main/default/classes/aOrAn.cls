public class aOrAn {
    public Static String aOrAnVowel(String word) {
        if (word != null) {
            if (word.startsWithIgnoreCase('a') || word.startsWithIgnoreCase('e') || word.startsWithIgnoreCase('i') || word.startsWithIgnoreCase('o') || word.startsWithIgnoreCase('u')) {
                return 'an ' + word;
            } else {
                return 'a ' + word;
            }
        }
        return word;
    }

}