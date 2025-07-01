trigger ContactTrigger on Contact (after insert, before insert, after update) {
    
    if( Trigger.isAfter ){
        if( Trigger.isInsert ){
            // ContactHandler.sendEmailToInsertedContact(Trigger.new); // Q.32
            // ContactHandler.updateContactCountOnAccount( Trigger.new); // Recursion 2
        }   

        if( Trigger.isUpdate ){
            // ContactHandler.updateAccountFieldMethod(Trigger.new); // Recursion 4
        }
    }

    if( Trigger.isBefore ){
        if( Trigger.isInsert ){
            // ContactHandler.preventDuplicateEmailContacts( Trigger.new );
        }
    }

}