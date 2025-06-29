public with sharing class OpportunityUtilityClass {
    public static void setDescriptionOnAmountBasis( List<Opportunity> oppList ){

        for( Opportunity opp : oppList ){
            if( opp.Amount > 100000 ){
                opp.Description = 'Hot Opportunity';
            }
        }

    }


    public static void updateRelatedAccountRecentOppAmount( List<Opportunity> oppList ){

        List<Account> accList = new List<Account>();

        for( Opportunity opp : oppList ){

            if( opp.AccountId != null ){
                Account acc = [ SELECT Id, Recent_Opportunity_Amount__c	FROM Account WHERE Id =:opp.AccountId ];
                acc.Recent_Opportunity_Amount__c = opp.Amount;

                accList.add( acc );
            }

        }

        if( accList != null ){
            update accList;
        } 
    }


    public static void updateOppDescriptionOnStage( List<Opportunity> oppList ){

        for( Opportunity opp : oppList ){

            if( opp.StageName == 'Closed Won' ){
                opp.Description = 'Opportunity is Closed Won';
            }
            else if( opp.StageName == 'Closed Lost' ){
                opp.Description = 'Opportunity is Closed Lost';
            }
            else{
                opp.Description = 'Opportunity is Open';
            }
            
        }

    }

    public static void createTaskRelatedToOpportunity( List<Opportunity> oppList, Map<Id, Opportunity> oppOldMap){ 
        List<Task> taskList = new List<Task>();

        for( Opportunity opp : oppList ){
            Opportunity oldOpp = oppOldMap.get(opp.Id);

            if( opp.StageName != oldOpp.StageName ){
                taskList.add( new Task( WhatId = opp.Id, Subject = 'Follow Up Test Task', OwnerId = UserInfo.getUserId() ) );
            }

        }


        if( !taskList.isEmpty() ){
            insert taskList;
        }
    }

    public static void checkIfAmountIsNull(List<Opportunity> oppList){
        for( Opportunity opp : oppList ){
            if( opp.Amount == null ){
                opp.addError('Amount field can\'t be null');
            } 
        }
    }

    public static void checkIfClosedLostReasonIsNull(List<Opportunity> oppList){
        for( Opportunity opp : oppList ){
            if( opp.Closed_Lost_Reason__c == null && opp.StageName == 'Closed Lost'  ){
                opp.Closed_Lost_Reason__c.addError('Please add a reason why this Opportunity is being closed as Lost.');
            }
        }
    }

    public static void preventOtherUsersToDeleteClosedOpportunity( List<Opportunity> oppList ){
        Id userProfileId = UserInfo.getUserId();
        Profile profileName = [ SELECT Name FROM Profile WHERE Id =: userProfileId ];

        for( Opportunity opp : oppList ){
            if( (opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost') && profileName.Name != 'System Administrator' ){
                opp.addError('A Closed Opportunity could be only deleted with a System Admin Profile');
            }
        }
    }

    

    public static void updateDescriptionForClosedStages(List<Opportunity> oppList, Map<Id, Opportunity> oldMap) {
        List<Opportunity> oppsToUpdate = new List<Opportunity>();

        for (Opportunity newOpp : oppList) {
            Opportunity oldOpp = oldMap.get(newOpp.Id);

            if (newOpp.StageName != oldOpp.StageName) {
                if (newOpp.StageName == 'Closed Won') {
                    Opportunity opp = new Opportunity(Id = newOpp.Id);
                    opp.Description = 'Opportunity is Closed Won';
                    oppsToUpdate.add(opp);
                } else if (newOpp.StageName == 'Closed Lost') {
                    Opportunity opp = new Opportunity(Id = newOpp.Id);
                    opp.Description = 'Opportunity is Closed Lost';
                    oppsToUpdate.add(opp);
                }
            }
        }

        if (!oppsToUpdate.isEmpty()) {
            update oppsToUpdate;
        }
    }
    
}