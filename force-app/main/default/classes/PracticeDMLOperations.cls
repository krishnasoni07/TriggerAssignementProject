public class PracticeDMLOperations {
    public static void insertFiveAccountWithContactRecords(){
        //List<Account> accList = [ SELECT Id, Name, BillingCity FROM Account Where Name LIKE 'Test Account%' LIMIT 5 ];
        //List<Contact> conList = [ SELECT Id, LastName FROM Contact Where Email = null ];
        
        /*
        for(Integer i = 1; i <= 5; i++){
            accList.add( new Account( Name = 'Test Account : ' + i ) );    
        }
        insert accList;
        
        for( Account accItr : accList ){
        	conList.add( new Contact( LastName = 'Doe', AccountId = accItr.Id ) );    
        }
        insert conList;

		*/
        
        /*
        for( Account accItr : accList ){
            accItr.BillingCity = 'Practice DML';
        }
        
        update accList;
        */
        
        //delete conList;
        
        
        
        //undelete [ SELECT Id, Name FROM Account Where Name = 'Test Account : 5' ALL ROWS ];
    
    	
        
        /*
        List<Contact> conList2 = new List<Contact>();
        
		for(Integer i = 1; i <= 10; i++) {
    		Contact con = new Contact( LastName = 'Test ' + i );
    		conList2.add(con);
            
            if( i == 5 ){
                conList2.add( new Contact() );
            }
            
		}

        Database.SaveResult[] results = Database.insert(conList2, false);
        
        for(Database.SaveResult res : results) {
            if(res.isSuccess()) {
                System.debug('Success : ' + res.getId());
            } else {
                for(Database.Error err : res.getErrors()) {
                    System.debug('Error: ' + err.getMessage());
                }
            }
        }

		*/
        
        
        Savepoint sp = Database.setSavepoint();
        
        try {
            Account acc = new Account(Name = 'Hell');
            insert acc;
        
            
            Contact con = new Contact(AccountId = acc.Id);
            insert con;
        
            Opportunity opp = new Opportunity(Name='TempOpp', CloseDate=Date.today().addDays(30), StageName='Prospecting', AccountId = acc.Id);
            insert opp;
        } catch(Exception e) {
            Database.rollback(sp);
            System.debug('Error: ' + e.getMessage());
        }


    }
}