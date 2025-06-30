public with sharing class CaseUtilityClass {

    public static void setCaseNumberInAccountRecord( List<Case> caseList ){
        List<Account> accList = new List<Account>();

        for( Case casee : caseList ){

            if( casee.AccountId != null ){
                Account acc = [ SELECT Id, Latest_Case_Number__c FROM Account WHERE Id =: casee.AccountId ];
                acc.Latest_Case_Number__c = casee.CaseNumber;
    
                accList.add(acc);
            }
        }

        if( accList != null ){
            update accList;
        }
    }

    public static void updateCaseRecordTypeCountOnAccount( List<Case> caseList ){

        Id partnerRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Partner Case R').getRecordTypeId();
        Id customerRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Customer Case R').getRecordTypeId();

        Set<Id> accountIdSet = new Set<Id>();
        for( Case cs : caseList ){
            if( cs.AccountId != null ){
                accountIdSet.add( cs.AccountId );
            }
        }

        List<Account> accList = [ SELECT Id, Partner_Case_Count__c, Customer_Case_Count__c, ( SELECT Id, RecordTypeId FROM Cases ) FROM Account WHERE Id IN : accountIdSet ];
        for( Account acc : accList ){
            
            for( Case cs : acc.Cases ){
                if( cs.RecordTypeId == partnerRecordTypeId ){
                    if( acc.Partner_Case_Count__c != null ){
                        acc.Partner_Case_Count__c += 1;
                    }
                    else {
                        acc.Partner_Case_Count__c = 1;
                    }
                }
                else if( cs.RecordTypeId == customerRecordTypeId ){
                    if( acc.Customer_Case_Count__c != null ){
                        acc.Customer_Case_Count__c += 1;
                    }
                    else {
                        acc.Customer_Case_Count__c = 1;
                    }
                }
            }

        }

        update accList;
    }

    
}