trigger UserTrigger on User (after insert) {
    if( Trigger.isAfter ){
        if( Trigger.isInsert ){
            UserHandler.addNewAdminToPublicGroup(Trigger.new);
        }
    }
}