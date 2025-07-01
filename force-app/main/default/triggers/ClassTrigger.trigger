trigger ClassTrigger on Class__c (before delete) {
    if( Trigger.isBefore ){
        if( Trigger.isDelete ){
            ClassHelper.preventClassDeletionByFemaleStudentCount( Trigger.oldMap );
        }

    }
}