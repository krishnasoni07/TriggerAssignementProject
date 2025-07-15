public with sharing class BatchApex3 implements Database.Batchable< SObject >, Database.Stateful{
    public Integer recordsPassed = 0;
    public Integer recordsFailed = 0;

    public List<Id> idList;

    public BatchApex3(){
        idList = new List<Id>();
    }

    public Database.QueryLocator start( Database.BatchableContext bc ){
        Date validatingDate = System.today().addDays(-10);
        return Database.getQueryLocator( ' SELECT Id, FirstName, LastName, Email FROM Contact WHERE LastModifiedDate < :validatingDate' );
    }

    public void execute( Database.BatchableContext bc, List<Contact> conList ){

        for( Contact con : conList ){
            con.FirstName = 'Anonymous';
            con.LastName = 'User';
            con.Email = null;
        }


        if( conList != null ){
            List<Database.SaveResult> conUpdateList = Database.update(conList, false);

            for( Database.SaveResult currentResult : conUpdateList ){
                if( currentResult.isSuccess() ){
                    idList.add(currentResult.getId());
                    recordsPassed++;
                }
                else{
                    recordsFailed++;
                }
            }
        }

    }

    public void finish( Database.BatchableContext bc ){
        System.debug( 'All Records which are Modified within the Last 10 Days are Updated.' );
        System.debug( '\nRecords Passed : ' + recordsPassed + '\n');
        System.debug( '\nRecords Failed : ' + recordsFailed + '\n');

        System.enqueueJob(new QueuableTest( idList ));
    }

}