trigger EmployeeTrigger on Employee__c (before insert, after delete, after undelete) {
    if( Trigger.isAfter ){
        if( Trigger.isDelete ){
            // EmployeeHandler.updateEmployeeLeftCount( Trigger.old ); // Q.28
        }

        if( Trigger.isUndelete ){
            EmployeeHandler.updateActiveAsYesOnUndelete(Trigger.new); // Q.29
        }
    }
}