public with sharing class PositionHandler {
    public static void populateMinMaxOpenFields( List<Position__c> posList ){
        for( Position__c pos : posList ){
            if( pos.Open_Date__c == null ){
                pos.Open_Date__c = System.today();
            }
            
            if( pos.Max_Pay__c == null ){
                pos.Max_Pay__c = 10000;
            }

            if( pos.Min_Pay__c == null ){
                pos.Min_Pay__c = 15000;
            }


        }
    }

}