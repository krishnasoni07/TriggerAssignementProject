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


    

}