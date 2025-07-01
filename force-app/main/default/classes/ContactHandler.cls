public with sharing class ContactHandler {

    public static void sendEmailToInsertedContact( List<Contact> conList ){
        List<Messaging.SingleEmailMessage> emailsList = new List<Messaging.SingleEmailMessage>();

        EmailTemplate template = [ SELECT Id FROM EmailTemplate WHERE Name = 'Trigger Test Template' ];

        for( Contact con : conList ){
            Messaging.SingleEmailMessage tempSingleEmailObject = new Messaging.SingleEmailMessage();

            tempSingleEmailObject.setTargetObjectId( con.Id );
            tempSingleEmailObject.setTemplateId( template.Id );

            emailsList.add(tempSingleEmailObject);
        }

        Messaging.sendEmail(emailsList);
    }


    public static void updateContactCountOnAccount( List<Contact> conList ){
        Map<Id, Integer> accountIdWithContactCount = new Map<Id,Integer>();

        for( Contact con : conList ){
            if( con.AccountId != null ){
                if( accountIdWithContactCount.containsKey(con.AccountId) ){
                    accountIdWithContactCount.put(con.AccountId, accountIdWithContactCount.get(con.AccountId)  + 1);
                }
                else{
                    accountIdWithContactCount.put(con.AccountId, 1);
                }
            }
        }

        List<Account> accList = [ SELECT Id, Contact_Count__c FROM Account WHERE Id IN :accountIdWithContactCount.keySet() ];

        for( Account acc : accList ){
            acc.Contact_Count__c = ( acc.Contact_Count__c == null ? accountIdWithContactCount.get(acc.Id) : (accountIdWithContactCount.get(acc.Id) + acc.Contact_Count__c)  ) ;
        }

        if( accList != null ){
            update accList;
        }
    }


    public static void updateAccountFieldMethod( List<Contact> conList ){
        List<Account> accList = [ SELECT Id, Phone FROM Account WHERE Id = :conList.get(0).AccountId ];

        accList.get(0).Phone += '1';
        update accList;
    }

}