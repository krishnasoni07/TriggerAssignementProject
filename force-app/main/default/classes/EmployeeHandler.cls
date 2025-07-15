public with sharing class EmployeeHandler {
    public static void updateEmployeeLeftCount(List<Employee__c> empList) {
        Map<Id, Integer> empIdMapWithCount = new Map<Id, Integer>();

        
        for (Employee__c emp : empList) {
            if (emp.Department__c != null) {
                if (empIdMapWithCount.containsKey(emp.Department__c)) {
                    empIdMapWithCount.put(emp.Department__c, empIdMapWithCount.get(emp.Department__c) + 1);
                } else {
                    empIdMapWithCount.put(emp.Department__c, 1);
                }
            }
        }

        List<Account> accList = [SELECT Id, Left_Employee_Count__c FROM Account WHERE Id IN :empIdMapWithCount.keySet()];

        for (Account acc : accList) {
            Integer deletedCount = empIdMapWithCount.get(acc.Id);
            acc.Left_Employee_Count__c = (acc.Left_Employee_Count__c == null ? 0 : acc.Left_Employee_Count__c) - deletedCount;
        }

        if (!accList.isEmpty()) {
            update accList;
        }
    }

    public static void updateActiveAsYesOnUndelete( List<Employee__c> empList ){
        List<Employee__c> updatedEmployee = new List<Employee__c>();

        for (Employee__c emp : empList) {
            Employee__c temp = new Employee__c( Id = emp.Id, Employment_Status__c = 'Active' );
            updatedEmployee.add(temp);            
        }

        if( updatedEmployee != null ){
            update updatedEmployee;
        }
    }
}