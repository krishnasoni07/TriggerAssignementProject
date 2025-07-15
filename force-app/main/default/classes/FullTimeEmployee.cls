public with sharing class FullTimeEmployee extends Employee implements ReportInterface {
    public FullTimeEmployee( String name, String department, String employeeId, Integer salary ) {
        this.department = department;
        this.employeeId = employeeId;
        this.name = name;
        this.salary = salary;
    }

    public void displayReports(){
        System.debug('FullTimeEmployee reports:' + '\n' +
        'Department:' + department + '\n' +
        'Employee Id:' +  employeeId + '\n' +
        'Name:' +  name + '\n' +
        'Salary:' + salary + '\n');
    }

    public override Integer calculateSalary( Integer month ){
        return month * salary;
    }
}