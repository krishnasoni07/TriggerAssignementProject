public class BatchAssignment2 implements Database.Batchable<SObject>, Database.Stateful {

    public Integer recordsProcessed = 0;
    public Integer recordsPassed = 0;
    public Integer recordsFailed = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Is_Inactive__c FROM Contact WHERE LastModifiedDate != THIS_MONTH'
        );
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        recordsProcessed += scope.size();

        for (Contact con : scope) {
            con.Is_Inactive__c = true;
        }

        try {
            update scope;
            recordsPassed += scope.size();
        } catch (DmlException e) {
            System.debug(e.getMessage());
            recordsFailed += scope.size();
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Records processed : ' + recordsProcessed);
        System.debug('Records passed : ' + recordsPassed);
        System.debug('Records failed : ' + recordsFailed);
    }
}