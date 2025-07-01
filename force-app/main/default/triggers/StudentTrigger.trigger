trigger StudentTrigger on Student__c (before insert) {
    if( Trigger.isBefore ){
        if( Trigger.isInsert ){
            
        }
    }
}