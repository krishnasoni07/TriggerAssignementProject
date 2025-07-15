public with sharing class Hell1 {
    
    public static void getContactAndLeadsByName( String name ){
        List<List<SObject>> searchResults = [FIND :('*' + name + '*') IN ALL FIELDS RETURNING Contact(Id, Name), Lead(Id, Name)];

        List<Contact> conList = (List<Contact>)searchResults[0];
        List<Lead> leadList = (List<Lead>)searchResults[1];
        
        
        for( Contact con : conList ){
            System.debug( con.Id + ' => ' + con.Name );
        }
        
        for( Lead obj : leadList ){
            System.debug( obj.Id + ' => ' + obj.Name );
        }
    }

    
    public static void getAccountAndCases( String name ){
        List<List<SObject>> searchResults = [FIND :('*' + name + '*') IN ALL FIELDS RETURNING Account(Id, Name), Case(Id)];

        List<Account> conList = (List<Account>)searchResults[0];
        List<Case> leadList = (List<Case>)searchResults[1];
        
        
        for( Account con : conList ){
            System.debug( con.Id + ' => ' + con.Name );
        }
        
        for( Case obj : leadList ){
            System.debug( obj.Id );
        }
    }

    
    public static void getCasesByName( String name ){
        List<List<SObject>> searchResults = [ FIND :('*' + name + '*') IN ALL FIELDS RETURNING Case(Id, Subject) ];
        
        List<Case> caseList = (List<Case>)searchResults.get(0);
        
        for( Case cs : caseList ){
            System.debug( cs.Id + ' => ' + cs.Subject );
        }
    }
    
    public static void getUsersAndGroupsByName(String name) {
        List<List<SObject>> searchResults = [FIND :('*' + name + '*') IN ALL FIELDS RETURNING User(Id, Name), Group(Id, Name)];
        
        List<User> userList = (List<User>)searchResults.get(0);
        List<Group> groupList = (List<Group>)searchResults.get(1);
        
        for (User usr : userList) {
            System.debug(usr.Id + ' => ' + usr.Name);
        }
        
        for (Group grp : groupList) {
            System.debug(grp.Id + ' => ' + grp.Name);
        }
    }

    public static void getLeadsByKeyword(String name) {
        List<List<SObject>> searchResults = [FIND :('*' + name + '*') IN ALL FIELDS RETURNING Lead(Id, Name)];
        
        List<Lead> leadList = (List<Lead>)searchResults.get(0);
        
        for (Lead ld : leadList) {
            System.debug(ld.Id + ' => ' + ld.Name);
        }
    }
    
    public static void getAccountsAndContactsByPartialTerm(String name) {
        List<List<SObject>> searchResults = [FIND :('*' + name + '*') IN ALL FIELDS RETURNING Account(Id, Name), Contact(Id, Name)];
        
        List<Account> accList = (List<Account>)searchResults.get(0);
        List<Contact> conList = (List<Contact>)searchResults.get(1);
        
        for (Account acc : accList) {
            System.debug(acc.Id + ' => ' + acc.Name);
        }
        
        for (Contact con : conList) {
            System.debug(con.Id + ' => ' + con.Name);
        }
    }


    

    public String reverseString(String str) {
        String revString = '';
        for(Integer j = str.length() - 1; j >= 0; j--) {
            revString += str.substring(j, j + 1);
        }
        return revString;
    }


    public Boolean checkPalindrome(String str){
        for(Integer i = 0 , j = str.length() - 1; i < str.length() / 2;i++){
            if( str.charAt(i) != str.charAt(j)){
                return false; 
            }
            j--;
        }
        return true;
    }

    public Integer countVowels(String str){
        
        str = str.toLowerCase();
        Integer vowel = 0;
        Integer consonant = 0;

        for(Integer i = 0; i < str.length();i++){

            String temp = String.valueOf(str.charAt(i));

            if( temp != '32' ){
                switch on temp {
                    when '97' {
                        vowel++;
                    } 
                    when '101' {
                        vowel++;
                    } 
                    when '105' {
                        vowel++;
                    } 
                    when '111' {
                        vowel++;
                    } 
                    when '117' {
                        vowel++;
                    }
                    when else {
                        consonant++;
                    }
                }
            }

        }

        System.debug('Vowels Count : ' + vowel);
        System.debug('Consonants Count : ' + consonant);

        return vowel;
    }

   public Boolean isPrime(Integer num) {
        if (num <= 1) return false; 
    
        for (Integer i = 2; i <= Math.floor(Math.sqrt(num)); i++) {
            if (Math.mod(num, i) == 0)
                return false;
        }
        return true;
    }


    public void fizzBuzz(){

        for(Integer i = 1; i <= 100; i++){

            if( Math.mod( i , 3 ) == 0 )
                System.debug('Fizz\n');

            else if( Math.mod(i , 5) == 0 ){
                System.debug('Buzz\n');
            }

            else{
                System.debug(i + '\n');
            }

        }

    }

    public Integer getFactorial(Integer num){

        Integer fact = 1;

        for(Integer i = 1; i <= num;i++)
            fact *= i;

        return fact;
    }

    public void printFibonacci( Integer num ){

        Integer a = 0, b = 1;
        Integer c = 0;

        Integer count = 1;


        if( num == 1)
            System.debug('0');
        else {
            System.debug('0');
            while( count != num ){
    
                System.debug('Fibonacci : ' + c );
    
                a = b;
                b = c;
                c = a + b;

                count++;
    
            }
        }
    }

    public void printEvenOddCount( List <Integer> arr ) {
        
        Integer even = 0, odd = 0;

        for(Integer i : arr){

            if( Math.mod(i , 2) == 0)
                even++;
            else {
                odd++;
            }
        }

        System.debug('\n\n' + even);
        System.debug('\n\n' + odd);
    }

    public Integer getDigitsCount(Integer num){

        Integer sum = 0;

        while( num > 0 ){
            Integer rem = Math.mod(num , 10);
            num /= 10;

            sum += rem;
        }

        return sum;
        
    }

    public Boolean isArmstrong(Integer num){

        Integer temp = num;
        Integer digitsCount = 0;
        Integer sum = 0;
        Integer pow = 1;


        while(temp > 0){
            digitsCount++;
            temp /= 10;
        }

        temp = num;


        while( temp > 0 ){
            Integer rem = Math.mod(temp , 10);
            temp /= 10;

            pow = 1;
            for(Integer j = 1; j <= digitsCount;j++)
                pow *= rem;

            sum += pow;
        }

        if( sum == num )
            return true;
        else
            return false;

    }

    public List<Integer> getUniqueElements( List<Integer> arr ){
        List<Integer> temp = new List<Integer>();

        for(Integer i = 0; i < arr.size();i++){
            Boolean flag = true;

            if( arr.get(i) != -1 ){
                for(Integer j = i + 1; j < arr.size();j++){
                    if( arr.get(i) == arr.get(j) ){
                        arr.set(i, -1);
                        arr.set(j, -1);
                        flag = false;
                        break;
                    }
                }
                if( flag == true ){
                    temp.add(arr.get(i));
                }
            }

        }

        return temp;
    }

    public void sortToDescending( List<Integer> arr){

        Integer n = arr.size();

        for (Integer i = 0; i < n - 1; i++) {
            for (Integer j = 0; j < n - i - 1; j++) {
                if (arr.get(j) < arr.get(j + 1)) {
                    
                    Integer temp = arr.get(j);
                    arr.set(j, arr.get(j + 1));
                    arr.set(j + 1, temp);

                }
            }
        }

        System.debug('\n\n' + arr + '\n\n');

    }


    public List<Integer> sortToAscending(List<Integer> arr) {
        Integer n = arr.size();
        Boolean swapped;
    
        for (Integer i = 0; i < n - 1; i++) {
            swapped = false;
    
            for (Integer j = 0; j < n - i - 1; j++) {
                if (arr.get(j) > arr.get(j + 1)) {
                    Integer temp = arr.get(j);
                    arr.set(j, arr.get(j + 1));
                    arr.set(j + 1, temp);
                    swapped = true;
                }
            }
    
            if (!swapped) break;
        }
    
        return arr;
    }
    

    public void printLargestAndSmallest( List<Integer> arr ){

        Integer min = arr.get(0);
        Integer max = arr.get(0);

        for(Integer i = 1; i < arr.size();i++){
            if( arr.get(i) < min )
                min = arr.get(i);
            if( arr.get(i) > max )
                max = arr.get(i);
        } 

        System.debug( '\n\nSmallest : ' + min + '\nLargest : ' + max + '\n\n' );
    }

    public List<Integer> getCommonElemetns( List<Integer> arr1, List<Integer> arr2 ){ 
        List<Integer> temp = new List<Integer>();

        for(Integer i = 0; i < arr1.size();i++){

            if( arr2.contains(arr1.get(i)) && !( temp.contains(arr1.get(i)) ))
                temp.add(arr1.get(i));

        }

        return temp;

    }

    public void printSecondLargestNumber(List<Integer> arr){

        Integer max = arr.get(0);
        Integer smax = arr.get(0);

        for(Integer i = 1; i < arr.size();i++){

            if( arr.get(i) > max ){
                smax = max;
                max = arr.get(i);
            }
            else if( arr.get(i) > smax && arr.get(i) != max ){
                smax = arr.get(i);
            }

        }

        System.debug('\n\n' + smax + '\n\n');
    }


    public void patternOne( Integer num ){

        Integer startingAlphabets = 0;
        Integer endingAlphabets = 26;
        String alphabets = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        

        System.debug('\n');
        System.debug('\n');

        

        for(Integer i = 1; i <= num; i++){
            String patternLine = '';

            for(Integer j = 1; j <= i; j++){
                if( Math.mod(i,2) != 0 ){
                    patternLine += alphabets.substring( startingAlphabets , startingAlphabets + 1 );
                    startingAlphabets++;
                }
                else{
                    patternLine += alphabets.substring( endingAlphabets - 1 , endingAlphabets );
                    endingAlphabets--; 
                }
            }
            
            System.debug(patternLine);
        }

        System.debug('\n');
        System.debug('\n');
    }

    public void patternTwo( Integer num ){

        for(Integer i = 0; i < num; i++){
            String row = '';

            for(Integer j = 1; j < num * 2;j++){
                if( j <= num - i || j >= num + i ){
                    row += '*';
                }
                else {
                    row += '_';
                }
            }
            System.debug( row );
        }

    }
  

    public void printAlphabetCount( String str ){

        Map< String , Integer > countSortObj = new Map<String, Integer>();

        for( Integer i = 0; i < str.length(); i++ ){


            if( countSortObj.containsKey( str.subString( i , i + 1 ) ) ){

                countSortObj.put( str.subString( i , i + 1 ) , countSortObj.get( str.subString( i , i + 1 ) ) + 1 );
            }
            else{

                countSortObj.put( str.subString( i , i + 1 ) , 1 );
            }

        }

        Set<String> allKeys = countSortObj.keySet();

        for(String key : allKeys){

            System.debug( '               ' + key + ' : ' + countSortObj.get( key ) );
        }

        // System.debug( '\n\n' + countSortObj + '\n\n');

    }


    // public List<Integer> getSortedMergedList( List<Integer> l1, List<Integer> l2 ){
    //     for(Integer i = 0; i < l2.size() ; i++){
    //         l1.add( l2.get(i) );
    //     }

    //     sortToAscending(l1);
        
    //     return l1;
    // }

    public List<Integer> getSortedMergedList(List<Integer> l1, List<Integer> l2) {
        List<Integer> merged = new List<Integer>();
        merged.addAll(l1);
        merged.addAll(l2);
    
        sortToAscending(merged);
    
        return merged;
    }
    

}