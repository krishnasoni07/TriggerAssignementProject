public with sharing class TeacherHelper {

    public static void avoidTeacherCreationIfSubjectIncluesHindi( List< Teacher__c > techList ){
        
        for( Teacher__c tech : techList ){
            if( tech.Subjects__c != null && tech.Subjects__c.contains('Hiindi') ) {
                tech.addError('Can\'t create a teacher with subject Hindi');
            }
        }

    }

}