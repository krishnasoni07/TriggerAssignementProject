public with sharing class PartTimeEmployee extends Employee implements ReportInterface {
    public PartTimeEmployee( String name, String department, String employeeId, Integer salary ) {
        this.department = department;
        this.employeeId = employeeId;
        this.name = name;
        this.salary = salary;
    }

    public void displayReports(){
        System.debug('PartTimeEmployee reports:' + '\n' +
        'Department:' + department + '\n' +
        'Employee Id:' +  employeeId + '\n' +
        'Name:' +  name + '\n' +
        'Salary:' + salary + '\n');
    }

    public override Integer calculateSalary( Integer hTime ){
        return hTime * salary;
    }
}