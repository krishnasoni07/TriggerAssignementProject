public with sharing class StudentHandler {

    public static void preventInsertionIfClassIsFull( List<Student__c> stuList ){

        Set<Id> classesIdSet = new Set<Id>();
        Map<Id, Boolean> isSeatAvailable = new Map<Id, Boolean>();

        for( Student__c stu : stuList ){
            classesIdSet.add( stu.Class__c );
        }

        List<Class__c> classList = [ SELECT Id, Max_Size__c, ( SELECT Id, Class__c FROM Students__r  ) FROM Class__c WHERE Id IN :classesIdSet];


        for( Class__c cls : classList ){
            if( cls.Max_Size__c <= cls.Students__r.size() ){
                isSeatAvailable.put( cls.Id, false );
            }
        }

        for( Student__c stu : stuList ){
            if( isSeatAvailable.containsKey(stu.Class__c) ){
                stu.addError('Current class is already filled with Students, no more students can be added now.');
            }
        }

    }


    public static void updateMyCountOnClass( List<Student__c> stuList ){
        
        Set<Id> classIDs = new Set<Id>();

        for( Student__c stu : stuList ){
            classIDs.add(stu.Class__c);
        }

        List<Class__c> clsList = [ SELECT Id, Name, My_Count__c, ( SELECT Id FROM Students__r ) FROM Class__c WHERE Id IN :classIDs ];

        for( Class__c cls : clsList ){
            cls.My_Count__c = cls.Students__r.size();
        }

        update clsList;
    }

}


// trigger StudentTrigger on Student__c (before insert) {

//     Set<Id> classIds = new Set<Id>();
//     for (Student__c stu : Trigger.new) {
//         if (stu.Class__c != null) {
//             classIds.add(stu.Class__c);
//         }
//     }

//     // Get current student count per class
//     Map<Id, Integer> classIdToExistingCount = new Map<Id, Integer>();

//     for (AggregateResult ar : [ SELECT Class__c, COUNT(Id) total FROM Student__c WHERE Class__c IN :classIds GROUP BY Class__c ]) {
//         classIdToExistingCount.put( (Id)ar.get('Class__c') , (Integer)ar.get('total') );
//     }

//     // Count how many students are being inserted per class in this batch
//     Map<Id, Integer> classIdToNewCount = new Map<Id, Integer>();
//     for (Student__c stu : Trigger.new) {
//         if (stu.Class__c != null) {
//             Integer current = classIdToNewCount.containsKey(stu.Class__c) ? classIdToNewCount.get(stu.Class__c) : 0;
//             classIdToNewCount.put(stu.Class__c, current + 1);
//         }
//     }

//     // Query max limits for involved classes
//     Map<Id, Class__c> classMap = new Map<Id, Class__c>(
//         [SELECT Id, MaxLimit__c FROM Class__c WHERE Id IN :classIds]
//     );

//     for (Student__c stu : Trigger.new) {
//         if (stu.Class__c != null) {
//             Integer existing = classIdToExistingCount.containsKey(stu.Class__c) ? classIdToExistingCount.get(stu.Class__c) : 0;
//             Integer newCount = classIdToNewCount.containsKey(stu.Class__c) ? classIdToNewCount.get(stu.Class__c) : 0;
//             Integer total = existing + newCount;

//             if (classMap.containsKey(stu.Class__c) && total > classMap.get(stu.Class__c).MaxLimit__c) {
//                 stu.addError('Cannot insert student: class has reached its maximum limit.');
//             }
//         }
//     }
// }