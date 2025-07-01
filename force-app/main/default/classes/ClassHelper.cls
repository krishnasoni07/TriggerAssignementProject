public with sharing class ClassHelper {
    public static void preventClassDeletionByFemaleStudentCount( Map<Id, Class__c> classList ){
        Set<Id> classRecordId = new Set<Id>();

        for( Class__c cls : classList.values() ){
            classRecordId.add( cls.Id );
        }

        List<Class__c> clsList = [ SELECT Id, Name , ( SELECT Id, Name FROM Students__r WHERE Sex__c = 'Female' ) FROM Class__c WHERE Id IN :classRecordId];

        for( Class__c cls : clsList ){
            if (cls.Students__r != null && cls.Students__r.size() > 1){
                System.debug( '\n\n' + cls.Students__r.size() + '\n\n' );
                classList.get( cls.Id ).addError('Can\'t delete a class with more than 1 female count');
                System.debug( '\n\n' + cls.Students__r.size() + '\n\n' );
            }
        }

    }
}