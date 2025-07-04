public class BatchApex1 implements Database.Batchable<SObject>, Database.Stateful {
    
    public Integer recordProcessed = 0;
    public Integer recordFailed = 0;
    public Integer recordPassed = 0;
    
    public Database.QueryLocator start( Database.BatchableContext bc ){
        return Database.getQueryLocator( 'SELECT Id, CloseDate FROM Opportunity WHERE StageName = \'Closed Won\' AND CloseDate = LAST_N_DAYS:30' );
    }
    
    public void execute( Database.BatchableContext bc, List<Opportunity> scope ){
        System.debug( '\n\n\n' + bc + '\n\n\n');
        for( Opportunity opp : scope ){
            opp.CloseDate = System.today();
        }
        recordProcessed += scope.size();
        
        try{
            if( scope != null ){
                update scope;
                recordPassed += scope.size();
            }    
        }
        catch( DmlException  e ){
            System.debug( '\n\n\n'+ e.getMessage() + '\n\n\n');
            recordFailed += scope.size();
        }
        
    }
    
    public void finish( Database.BatchableContext bc ){
        System.debug( 'Records Processed : ' + recordProcessed );
        System.debug('Records Passed : ' + recordPassed);
        System.debug( 'Records Failed : ' + recordFailed );
        
    }
    
}