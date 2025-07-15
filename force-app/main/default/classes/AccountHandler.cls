public class AccountHandler {
    public static void insertAccount( Integer num ){
        
        List<Account> addAccounts = new List<Account>();
        
        for(Integer i = 1; i <= num; i++){
            String accName = 'Acme Inc ' + i;
            String accNumb = 'A000' + i;
            
            addAccounts.add(new Account( Name = accName, AccountNumber = accNumb ));
        }
        
        insert addAccounts;
        
    }
}