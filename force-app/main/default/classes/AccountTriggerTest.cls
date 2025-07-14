
@isTest
private with sharing class AccountTriggerTest {

    @isTest
    private static void testRatingAsPerIndustry(){
        Account acc = new Account(name = 'Krishna', Rating = 'Cold', Industry = 'Media');
        insert acc;
    }

}