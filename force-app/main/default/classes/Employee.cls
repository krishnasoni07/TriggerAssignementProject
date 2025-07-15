public abstract with sharing class Employee {

    public String name;
    public String employeeId;
    public String department;
    public Integer salary;

    public abstract Integer calculateSalary(Integer hTime);

    public Employee() {
    }
}