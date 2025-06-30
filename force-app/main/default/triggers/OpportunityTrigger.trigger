trigger OpportunityTrigger on Opportunity (before insert, after insert, before update, after update, before delete) {

    if( Trigger.isBefore && Trigger.isInsert ){
        //OpportunityUtilityClass.setDescriptionOnAmountBasis(Trigger.new); //Q.2
        //OpportunityUtilityClass.updateOppDescriptionOnStage(Trigger.new); // Q.13

        // OpportunityUtilityClass.checkIfAmountIsNull(Trigger.new); // Q.22
    }
    
    if( Trigger.isBefore && Trigger.isUpdate ){
        //OpportunityUtilityClass.updateOppDescriptionOnStage(Trigger.new); // Q.13

        // OpportunityUtilityClass.checkIfClosedLostReasonIsNull(Trigger.new); // Q.23

        OpportunityUtilityClass.updateCloseDateOnBasisOfStageName( Trigger.new, Trigger.oldMap );// Q.47
    }

    if( Trigger.isAfter && Trigger.isUpdate ){

        // OpportunityUtilityClass.createTaskRelatedToOpportunity(Trigger.new, Trigger.oldMap); // Q.18
        // OpportunityUtilityClass.updateDescriptionForClosedStages(Trigger.new, Trigger.oldMap); // Q.37

    }

    if( Trigger.isAfter && Trigger.isInsert ){
        OpportunityUtilityClass.updateRelatedAccountRecentOppAmount(Trigger.new); //Q.8
        
    }

    if( Trigger.isBefore && Trigger.isDelete ){
        //OpportunityUtilityClass.preventOtherUsersToDeleteClosedOpportunity(Trigger.new);// Q.25
    }

}