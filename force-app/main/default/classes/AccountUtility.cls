public class AccountUtility {
    
    public static void viewAnnualRevenue() {
        
        // Create a list to hold Account records
        List<Account> accountsList = [SELECT Name, AnnualRevenue FROM Account];
        
        // Iterate through the list of accounts
        for(Account acc : accountsList) {
            
            // Concatenate Account Name and Annual Revenue
            String acctRev = acc.Name + ' : ' + acc.AnnualRevenue;
            
            // Print to debug log
            System.debug(acctRev);
        }
    }
}