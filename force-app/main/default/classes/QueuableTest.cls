public with sharing class QueuableTest implements Queueable{
    List<Id> idList;

    public QueuableTest( List<Id> idList ) {
        this.idList = idList;
    }

    public void execute( QueueableContext qc ){
        Cleanup_Audit__c temp = new Cleanup_Audit__c();

        temp.Job_Run_Time__c = System.now();
        temp.Description__c = idList.size() + ' inactive contacts anonymized ';

        for( Contact con : [ SELECT Id FROM Contact WHERE Id IN: idList ] ){
            temp.Processed_Contact_Records__c += con.Id + ', ';
        }

        insert temp;

        FutureChatterMethod.createPost('0F9gL0000000lmv', System.now(), idList.size());
    }

}