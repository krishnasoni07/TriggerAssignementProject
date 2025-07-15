public with sharing class ScheduleTestClass implements Schedulable{
    
    public void execute( SchedulableContext sc ){
        System.debug( 'Test Schedule Class\'s Execute Method executed.' );
    }

}