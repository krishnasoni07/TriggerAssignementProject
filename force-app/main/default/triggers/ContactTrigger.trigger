trigger ContactTrigger on Contact (after insert, before insert) {
    
    if( Trigger.isAfter ){
        if( Trigger.isInsert ){
            // ContactHandler.sendEmailToInsertedContact(Trigger.new); // Q.32
        }   
    }

    if( Trigger.isBefore ){
        if( Trigger.isInsert ){
            ContactHandler.preventDuplicateEmailContacts( Trigger.new );
        }
    }

}