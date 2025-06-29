trigger ContactTrigger on Contact (after insert) {
    
    if( Trigger.isAfter ){
        if( Trigger.isInsert ){
            // ContactHandler.sendEmailToInsertedContact(Trigger.new); // Q.32
        }   
    }

}