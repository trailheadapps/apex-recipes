public class isPassed {
    public static Boolean isPassedCheck(Boolean passedExam, Boolean passedAssignments, Boolean passedProject) {
    if ((passedExam && passedAssignments) || 
        (passedAssignments && passedProject) || 
        (passedProject && passedExam)) {
              return true;
    } else {
        return false;
   }

}

}