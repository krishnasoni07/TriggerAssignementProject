trigger PositionTrigger on Position__c (before insert) {
    if( Trigger.isBefore ){
        if(Trigger.isInsert){
            PositionHandler.populateMinMaxOpenFields(Trigger.New);
        }
    }
}