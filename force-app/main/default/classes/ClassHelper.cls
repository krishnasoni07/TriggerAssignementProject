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


    public static void deleteStudentIfStatusEqualsReset( List<Class__c> clsList, Map<Id, Class__c> clsOldMap ){

        Set<Id> classRecordsId = new Set<Id>();

        for( Class__c cls : clsList ){
            Class__c temp = clsOldMap.get(cls.Id);

            if( temp.Custom_Status__c != cls.Custom_Status__c && cls.Custom_Status__c == 'Reset' ){
                classRecordsId.add( cls.Id );
            }
        }

        List<Student__c> stuList = [ SELECT Id FROM Student__c WHERE Class__c IN :classRecordsId ];

        if( stuList != null ){
            delete stuList;
        }

    }



}