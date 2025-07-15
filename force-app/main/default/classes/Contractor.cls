public with sharing class Contractor extends Employee implements ReportInterface {
    public Contractor( String name, String department, String employeeId, Integer salary ) {
        this.department = department;
        this.employeeId = employeeId;
        this.name = name;
        this.salary = salary;
    }

    public void displayReports(){
        System.debug('Contractor reports:' + '\n' +
        'Department:' + department + '\n' +
        'Employee Id:' +  employeeId + '\n' +
        'Name:' +  name + '\n' +
        'Salary:' + salary + '\n');
    }

    public override Integer calculateSalary( Integer contracts){
        return contracts * salary;
    }

}