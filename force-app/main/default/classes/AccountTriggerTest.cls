@isTest
private with sharing class AccountTriggerTest {

    private static List<Account> getAccList( Integer num ){
        List<Account> accList = new List<Account>();
        
        for(Integer i = 1; i <= num;i++){
            accList.add( new Account( 
            	Name = 'Test ' + i,
                Active__c = 'Yes'
            ));
        }
        
        insert accList;
        return accList;
    }
    
    @isTest
    private static void testRatingAsPerIndustry(){
        Account accTest = new Account(name = 'Krishna', Industry = 'media');
        insert accTest;
        
        Account acc = [ SELECT Id, Rating FROM Account WHERE Id =:accTest.Id ];
        
        System.assertEquals( 'Hot', acc.Rating );
    }
    
    @isTest
    private static void testCopyBillingAddToShipping(){
        Account accTest = new Account( name = 'Test Record' );
        accTest.BillingCity = 'Test City';
        accTest.BillingState = 'Rajasthan';
        accTest.BillingCountry = 'India';
        accTest.CopyBillingToShipping__c = true;
        
        insert accTest;
        
        Account acc = [ SELECT Id, ShippingCity FROM Account WHERE Id =: accTest.Id ];
        
        System.assertEquals( 'Test City', acc.ShippingCity );
    }

    @isTest
    private static void testcreateOppOrConRecord(){
        Account accTest = new Account();
        accTest.Create_Opportunity__c = true;
        accTest.Create_Contact__c = true;
        accTest.Active__c = 'Yes';
        accTest.Name = 'Test Record';
        
        insert accTest;
        
        Opportunity opp = [ SELECT Id, Name, AccountId FROM Opportunity WHERE AccountId =: accTest.Id ][0];
        Contact con = [ SELECT Id, LastName, AccountId FROM Contact WHERE AccountId =: accTest.Id ][0];
        
        System.assertEquals( accTest.Name, opp.Name );
        System.assertEquals( accTest.Name, con.LastName );
    }
    
    @isTest
    private static void testupdateDescriptionOnPhoneUpdate(){
        
        String str = 'Phone is Updated! Old Value : ';
        
        Account accTest = new Account();
        accTest.Name = 'Test Record';
        accTest.Phone = '123456789';
        
        insert accTest;
        str += accTest.Phone + ' & New Value : ';
        
        accTest.Phone = '987654321';
        update accTest;
        
        str += accTest.Phone;
        
        Account acc = [ SELECT Id, Description FROM Account WHERE Id =: accTest.Id ];
        
        System.assertEquals( str, acc.Description );
        System.debug( acc.Description );
    }
    
    @isTest
    private static void testcopyBillingAddressToShippingAddress(){
        
        Account accTest = new Account( name = 'Test Record' );
        accTest.BillingCity = 'Test City';
        accTest.BillingState = 'Rajasthan';
        accTest.BillingCountry = 'India';
        
        insert accTest;
        
        accTest.CopyBillingToShipping__c = true;
        update accTest;
        
        Account acc = [ SELECT Id, ShippingCity FROM Account WHERE Id =: accTest.Id ];
        
        System.assertEquals( 'Test City', acc.ShippingCity );
        
    }
    
    @isTest
    private static void testchangeRatingAsPerIndustry(){
        Account accTest = new Account(name = 'Krishna');
        insert accTest;

        accTest.Industry = 'media';
        update accTest;

        Account acc = [ SELECT Id, Rating FROM Account WHERE Id =:accTest.Id ];
        
        System.assertEquals( 'Hot', acc.Rating );
    }


    @isTest
    private static void testPositivePreventRecordEditing(){
        List<Account> accList = [ SELECT Id, Name, LastModifiedDate FROM Account WHERE LastModifiedDate != LAST_N_DAYS:7 ];

        Integer i = 1;
        for( Account acc : accList ){
            acc.Name = acc.Name + i++;
        }

        update accList;
    }

    @isTest
    private static void testNegativePreventRecordEditing(){
        List<Account> accList = [ SELECT Id, Name, LastModifiedDate FROM Account WHERE LastModifiedDate = LAST_N_DAYS:7 ];

        Integer i = 1;
        for( Account acc : accList ){
            acc.Name = acc.Name + i++;
        }

        update accList;
    }

    @isTest
    private static void testUpdateContactPhoneField(){
        List<Account> accList = [ SELECT Id, Phone FROM Account LIMIT 5 ];

        Integer i = 1;
        for( Account acc : accList ){
            if( Math.mod(i, 2) == 0 )
                acc.Phone += i++;
        }

        update accList;

    }

    @isTest
    private static void testUpdateContactPhoneFieldSOQL(){
        testUpdateContactPhoneField();
    }

    @isTest
    private static void testUpdateContactMaillingAddress(){
        List<Account> accList = [ SELECT Id, BillingStreet FROM Account LIMIT 5 ];

        Integer i = 1;
        for( Account acc : accList ){
            if( Math.mod(i, 2) == 0 )
                acc.BillingStreet += i++;
        }

        update accList;
    }

    @isTest
    private static void testUpdateContactMailingAddressSOQL(){
        testUpdateContactMaillingAddress();
    }

    @isTest
    private static void testUpdateRelatedOppStageToCloseLost(){
        List<Account> accList = [ SELECT Id, Active__c, ( SELECT Id, StageName FROM Opportunities WHERE StageName = 'Closed Lost' ) FROM Account WHERE Active__c = 'Yes' ];

        for( Account acc : accList ){
            acc.Active__c = 'No';
        }

        update accList;
    }

    @isTest
    private static void testChangeRelatedContactOwnerId(){
        List<Account> accList = [ SELECT Id, OwnerId FROM Account LIMIT 5 ];

        for( Account acc : accList ){
            acc.OwnerId = '';
        }

        update accList;
    }

    @isTest
    private static void testChangeRelatedContactOwnerIdWithMap(){
        testChangeRelatedContactOwnerId();
    }

    @isTest
    private static void testStopToDeleteAccount(){
        
        List<Account> accTestList = getAccList(5);
        
        Account acc = new Account(
        	Name = 'Test 6',
            Active__c = 'No'
        );
        
        insert acc;
        
        accTestList.add( acc );

        try{
        	delete accTestList;    
        }
        catch(DmlException e){
            Boolean exceptionOccured = true;
            System.assertEquals(5 , e.getNumDml());
            
            System.assertEquals(true, exceptionOccured);
        }
        
        
        List<Account> deletedAccounts = [ SELECT Id, Name, Active__c, isDeleted FROM Account WHERE Id IN: accTestList ALL ROWS ];
        for( Integer i = 0; i < deletedAccounts.size();i++ ){
            if( deletedAccounts[i].Active__c == 'Yes' ){
                System.assert( deletedAccounts[i].isDeleted == false, 'Record with name ' + deletedAccounts[i].Name + ' isn\'t Deleted'  );
            }
            else{
                System.assert( deletedAccounts[i].isDeleted == true, 'Record with name ' + deletedAccounts[i].Name + ' is Deleted'  );
            }
        }
        
        //System.assertEquals( false, accList[0].isDeleted );
    }

    

}