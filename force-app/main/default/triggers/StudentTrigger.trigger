trigger StudentTrigger on Student__c (before insert, after insert) {
    if( Trigger.isBefore ){
        if( Trigger.isInsert ){
            StudentHandler.preventInsertionIfClassIsFull( Trigger.new );
        }
    }

    if( Trigger.isAfter ){
        if( Trigger.isInsert ){
            StudentHandler.updateMyCountOnClass( Trigger.new );
        }
    }
}