public with sharing class AccountUtilityClass {

    public static void changeRatingAsPerIndustry( List<Account> accList ){
        for( Account acc : accList ){
            if( acc.Industry != null && acc.Industry == 'media' ){
                acc.Rating = 'Hot';
            }
        }
    }


    public static void copyBillingAddressToShippingAddress( List<Account> accList ){

        for( Account acc : accList ){
            if( acc.CopyBillingToShipping__c ){
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingState = acc.BillingState;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingCountry = acc.BillingCountry;
            }
        }

    }

    public static void createRelatedContact( List<Account> accList ){
        List<Contact> conList = new List<Contact>();

        for( Account acc : accList ){
            conList.add(new Contact( LastName = acc.Name, AccountId = acc.Id ));
        }

        if( conList != null ){
            insert conList;
        }
    }

    public static void createRelatedOpportunity( List<Account> accList ){
        List<Opportunity> oppList = new List<Opportunity>();

        for( Account acc : accList ){
            if( acc != null ){
                oppList.add(new Opportunity( Name = acc.Name, AccountId = acc.Id, StageName = 'Prospecting', CloseDate = System.today() + 7 ));
            }
        }

        if( oppList != null ){
            insert oppList;
        }
    }


    public static void createOppOrConRecord( List<Account> accList ){

        List<Opportunity> oppList = new List<Opportunity>();
        List<Contact> conList = new List<Contact>();

        for( Account acc : accList ){

            if( acc.Create_Opportunity__c == true && acc.Active__c == 'Yes'){
                oppList.add( new Opportunity( Name = acc.Name, AccountId = acc.Id, StageName = 'Prospecting', CloseDate = System.today() + 7 ) );
            }

            if( acc.Create_Contact__c == true ){
                    conList.add( new Contact( LastName = acc.Name, AccountId = acc.Id, Email = 'TestEmail@gmail.com' ) );
            }

        }

        insert oppList;
        insert conList;

    }


    public static void updateDescriptionOnPhoneUpdate( List<Account> accList, Map< Id, Account > accMap ){

        for( Account acc : accList ){
            Account temp = accMap.get( acc.Id );

            if( temp.Phone != acc.Phone ){
                acc.Description = 'Phone is Updated! Old Value : ' + temp.Phone +  ' & New Value : ' + acc.Phone;
            }
        }

    }

    public static void updateContactPhoneField(List<Account> accList, Map<Id, Account> accMap ){
        Map< Id, Account > updatedAccounts = new Map< Id, Account >();

        for( Account acc : accList ){
            Account temp = accMap.get( acc.Id );

            if( acc.Phone != temp.Phone ){
                updatedAccounts.put( acc.Id, acc );
            }
        }

        List<Contact> conList = [ SELECT Id, HomePhone, AccountId FROM Contact WHERE AccountId IN :updatedAccounts.keySet() ];
        
        for( Contact con : conList ){
            con.HomePhone = updatedAccounts.get( con.AccountId ).Phone;
        }
        
        if( conList != null ){
            update conList;
        } 
    }

    public static void updateContactPhoneFieldSOQL( List<Account> accList, Map<Id, Account> accOldMap ){
        Set<Id> updatedAccountIDs = new Set<Id>();

        for( Account acc : accList ){
            Account temp = accOldMap.get(acc.Id);

            if( acc.Phone != temp.Phone ){
                updatedAccountIDs.add( acc.Id );
            }

        }

        List<Account> accConList = [ SELECT Id, Phone, ( SELECT Id, HomePhone, AccountId FROM Contacts ) FROM Account WHERE Id IN :updatedAccountIDs  ];
        List<Contact> conList = new List<Contact>();
        for( Account acc : accConList ){
            for( Contact con : acc.Contacts ){
                con.HomePhone = acc.Phone;
                conList.add(con);
            }
        }

        if( conList != null ){
            update conList;
        }
    }

    public static void updateContactMaillingAddress( List<Account> accList, Map<Id, Account> accOldMap ){
        Map<Id, Account> updatedAccounts = new Map<Id, Account>();

        for( Account acc : accList ){
            Account temp = accOldMap.get(acc.Id);

            if( temp.BillingStreet != acc.BillingStreet ){
                updatedAccounts.put(acc.Id, acc);
            }

        }

        List<Contact> conList = [ SELECT Id, MailingAddress, AccountId FROM Contact WHERE AccountId IN :updatedAccounts.keySet() ];
        
        for( Contact con : conList ){
            con.MailingStreet = updatedAccounts.get( con.AccountId).BillingStreet;
        }
        

        if( conList != null ){
            update conList;
        }
    }


    public static void updateContactMailingAddressSOQL( List<Account> accList, Map<Id, Account> accOldMap ){
        Set<Id> updatedAccountIDs = new Set<Id>();

        for( Account acc : accList ){
            Account temp = accOldMap.get(acc.Id);

            if( temp.BillingStreet != acc.BillingStreet ){
                updatedAccountIDs.add(acc.Id);
            }
        }

        List<Account> accConList = [ SELECT Id, BillingStreet , ( SELECT Id, MailingStreet, AccountId FROM Contacts ) FROM Account WHERE Id IN :updatedAccountIDs ];
        List<Contact> conList = new List<Contact>();

        for( Account acc : accConList ){
            for( Contact con : acc.Contacts ){
                con.MailingStreet = acc.BillingStreet;
                conList.add(con);
            }
        }

        if( conList != null ){
            update conList;
        } 

    }

 
    public static void updateRelatedOppStageToCloseLost( List<Account> accList, Map<Id,Account> accOldMap ){

        Map<Id, Account> updatedAccounts = new Map<Id, Account>();

        for( Account acc : accList ){
            Account temp = accOldMap.get(acc.Id);

            if( temp.Active__c == 'Yes' && acc.Active__c == 'No' ){
                  updatedAccounts.put(acc.Id, acc);
            }
        }

        List<Opportunity> oppList = [ SELECT Id, StageName, AccountId FROM Opportunity WHERE AccountId IN :updatedAccounts.keySet() ];

        for( Opportunity opp : oppList ){

            if( opp.StageName != 'Closed Won' ){
                opp.StageName = 'Closed Lost';
            }

        }

        if( oppList != null ){
            update oppList;
        }
    }


    public static void stopToDeleteAccount( List<Account> accList ){
        for( Account acc : accList ){
            if( acc.Active__c == 'Yes' ){
                acc.addError('A Active Account Couldn\'t be deleted');
            }       
        }
    }


    public static void preventRecordEditing( List<Account> accList ){

        for( Account acc : accList){
            if( acc.LastModifiedDate < System.Today() - 7 ){
                acc.addError('Record couldn\'t be edited as it is updated 7 Days Ago');
            }
        }

    }

    public static void preventOtherUsersToDeleteAccount( List<Account> accList ){

        Id userProfileId = UserInfo.getProfileId();
        Profile profileName = [ SELECT Name FROM Profile WHERE Id =: userProfileId ];

        for( Account acc : accList ){
            if( profileName.Name != 'System Administrator' ){
                acc.addError('Only System Admin Could Delete the Account');
            }
        }
    }

    public static void preventOppRelatedAccountDeletion( List<Account> accList ){

        Set<Id> accListAccountIDs = new Set<Id>();
        Set<Id> accountsWithOpportunity = new Set<Id>();

        for( Account acc : accList ){
            accListAccountIDs.add( acc.Id );
        }

        
        for( Opportunity opp : [ SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :accListAccountIDs ] ){
            accountsWithOpportunity.add( opp.AccountId );
        }

        for( Account acc:accList ){
            if( accountsWithOpportunity.contains(acc.Id) ){
                acc.addError('You cant delete a Account with related Opportunity');
            }
        }

    }


    public static void preventCaseRelatedAccountDeletion(List<Account> accList){

        Set<Id> accListAccountIDs = new Set<Id>();
        Set<Id> accountsWithCase = new Set<Id>();

        for(Account acc : accList){
            accListAccountIDs.add( acc.Id );
        }

        for( Case caseObj : [ SELECT Id, AccountId FROM Case WHERE AccountId IN :accListAccountIDs ] ){
            accountsWithCase.add( caseObj.AccountId );
        }

        for( Account acc : accList ){
            if( accountsWithCase.contains(acc.Id) ){
                acc.addError('Account with Related Case Couldn\'t be deleted');
            }
        }

    }

    public static void changeRelatedContactOwnerId(List<Account> newAccList, List<Account> oldAccList){

        Set<Id> accIdList = new Set<Id>();
        List<Account> accList = new List<Account>();


        for( Integer i = 0; i < newAccList.size();i++ ){
            if( newAccList.get(i).OwnerId != oldAccList.get(i).OwnerId ){
                accIdList.add( newAccList.get(i).Id );
                accList.add( newAccList.get(i) );
            }
        }

        List<Contact> conList = [ SELECT Id, AccountId, OwnerId FROM Contact WHERE AccountId IN :accIdList ];

        for( Contact con : conList ){

            for( Account acc : accList ){
                if( con.AccountId == acc.Id){
                    con.OwnerId = acc.OwnerId;
                    break;
                }
            }

        }

        if( conList != null ){
            update conList;
        }

    }


    public static void changeRelatedContactOwnerIdWithMap( List<Account> accList, Map<Id, Account> accOldMap ){
        Set<Id> changedAccountIDs = new Set<Id>();

        for( Account acc : accList ){
            Account temp = accOldMap.get( acc.Id );

            if( temp.OwnerId != acc.OwnerId ){
                changedAccountIDs.add( acc.Id );
            }
        }

        List<Contact> conList = [ SELECT Id, AccountId, OwnerId, Account.OwnerId FROM Contact WHERE AccountId IN : changedAccountIDs ];

        for( Contact con : conList ){
            con.OwnerId = con.Account.OwnerId;
        }

        if( conList != null )
            update conList;
    }


    public static Boolean methodExecuted = false;

    public static void updateDescriptionWithAvoidRecursion( List<Account> accList ){
        if( methodExecuted ) return;
        methodExecuted = true;

        for( Account acc : accList ){
            if( acc.Description == null ){
                acc.Description = 'Desc Field updated only once';
            }
        }
    }

    
    public static Boolean contactUpdated = false;

    public static void updateContactFieldMethod( List<Account> accList ){
        if( contactUpdated ) return;
        contactUpdated = true;

        List<Contact> conList = [ SELECT Id, HomePhone FROM Contact WHERE AccountId = :accList.get(0).Id ];

        conList.get(0).HomePhone += '1';

        update conList;
    }
    

}