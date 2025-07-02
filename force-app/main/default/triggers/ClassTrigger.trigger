trigger ClassTrigger on Class__c (before delete, after update) {
    if( Trigger.isBefore ){
        if( Trigger.isDelete ){
            ClassHelper.preventClassDeletionByFemaleStudentCount( Trigger.oldMap );
        }
    }

    if( Trigger.isAfter ){
        if( Trigger.isUpdate ){
            ClassHelper.deleteStudentIfStatusEqualsReset( Trigger.new, Trigger.oldMap );
        }
    }

}