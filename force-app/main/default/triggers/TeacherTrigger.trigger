trigger TeacherTrigger on Teacher__c (before insert, before update) {
    if( Trigger.isBefore ){
        if( Trigger.isInsert ){
            // TeacherHelper.avoidTeacherCreationIfSubjectIncluesHindi( Trigger.new ); // Q.43
        }
        
        if( Trigger.isUpdate ){
            // TeacherHelper.avoidTeacherCreationIfSubjectIncluesHindi( Trigger.new ); // Q.43
        }
    }
}