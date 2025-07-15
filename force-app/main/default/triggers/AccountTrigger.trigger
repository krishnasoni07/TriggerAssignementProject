trigger AccountTrigger on Account( before insert, after insert, before update, after update, before delete ){
    
    if( Trigger.isBefore && Trigger.isInsert){
        AccountUtilityClass.changeRatingAsPerIndustry(Trigger.new); // Q.1
        AccountUtilityClass.copyBillingAddressToShippingAddress(Trigger.new); // Q.3
    }

    if( Trigger.isAfter && Trigger.isInsert ){
        //AccountUtilityClass.createRelatedContact(Trigger.new);  // Q.5
        //AccountUtilityClass.createRelatedOpportunity(Trigger.new); // Q.6

        AccountUtilityClass.createOppOrConRecord(Trigger.new); // Q.9

    }

    if( Trigger.isBefore && Trigger.isUpdate ){
        AccountUtilityClass.updateDescriptionOnPhoneUpdate( Trigger.new , Trigger.oldMap ); // Q.10
        AccountUtilityClass.copyBillingAddressToShippingAddress(Trigger.new); // Q.11
        AccountUtilityClass.changeRatingAsPerIndustry(Trigger.new); // Q.12

        AccountUtilityClass.preventRecordEditing(Trigger.new);// Q.21

        //AccountUtilityClass.updateDescriptionWithAvoidRecursion(Trigger.new); // Recursion 1
    }

    if( Trigger.isAfter && Trigger.isUpdate ){
        AccountUtilityClass.updateContactPhoneField(Trigger.new, Trigger.oldMap); // Q.14
        AccountUtilityClass.updateContactPhoneFieldSOQL(Trigger.new, Trigger.oldMap);//Q.15
        AccountUtilityClass.updateContactMaillingAddress(Trigger.new, Trigger.oldMap); // Q.16
        AccountUtilityClass.updateContactMailingAddressSOQL(Trigger.new, Trigger.oldMap); //Q.17

        AccountUtilityClass.updateRelatedOppStageToCloseLost( Trigger.new, Trigger.oldMap ); // Q.19

        AccountUtilityClass.changeRelatedContactOwnerId( Trigger.new, Trigger.old );// Q.38
        AccountUtilityClass.changeRelatedContactOwnerIdWithMap( Trigger.new, Trigger.oldMap );// Q.39

        // AccountUtilityClass.updateContactFieldMethod(Trigger.new); // Recursion 4
    }
    
    if( Trigger.isBefore && Trigger.isDelete ){
        AccountUtilityClass.stopToDeleteAccount( Trigger.old );// Q.20
        // AccountUtilityClass.preventOtherUsersToDeleteAccount(Trigger.old); // Q.24
        // AccountUtilityClass.preventOppRelatedAccountDeletion(Trigger.old);//Q.26
        // AccountUtilityClass.preventCaseRelatedAccountDeletion(Trigger.old); // Q.27
    }


}