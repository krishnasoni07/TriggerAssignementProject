public with sharing class ExceptionAssignment {

    public static void Question1(){
        try{
            insert new Account();
        }
        catch( Exception e ){
            System.debug( e.getMessage() );
        }
    }

    public static void Question2(){
        try{
            List<Contact> conList = [ SELECT Id, Hell FROM Contact ];

            update conList;
        }
        catch( QueryException e ){
            System.debug(e.getMessage());
        }
        catch( DmlException e ){
            System.debug(e.getMessage());
        }
    }

    public static void Question3( Integer num1, Integer num2 ){
        try{
            System.debug( num1 / num2 );
        }
        catch( ArthemethicException e ){
            System.debug( 'Divide by zero Exception : ' + e.getMessage() );
        }
    }

    public static void Question4( String str ){
        try{
            if( str == null || str.isEmpty() )
                throw new InvalidDataException();
        }
        catch(InvalidDataException e){
            System.debug( 'Provided String is either null or empty' );
        }
    }

    public static void Question5(){
        List<Contact> conList = new List<Contact>();
        conList.add( new Contact( LastName = 'Soni' ) );
        conList.add( new Contact() );
        conList.add( new Contact( LastName = 'Hella' ) );

        try{
            insert conList;
        }
        catch( DmlException e){
            System.debug('A exception was occured in these Records : ');
            for( Integer i = 0; i < e.getNumDml(); i++ ){
                System.debug('Exception occured in : ' + i );
            }

            System.debug( '\n Exception : \n' + e.getMessage() );
        }
    }

    public static void Question6( String str ){
        try{
            if( str == null || str.isEmpty() )
                throw new InvalidDataException();
        }
        catch(InvalidDataException e){
            System.debug( '\nProvided String is either null or empty' );
            System.debug(e.getMessage());
            System.debug(e.getTypeName());
            System.debug(e.getLineNumber());
            System.debug(e.getStackTraceString());
        } 
    }

    public static void Question7(){
        try{
            try{
                insert new Account();
            }
            catch( DmlException e ){
                System.debug( e.getMessage() );
            }

            throw new Exception();
        }
        catch( Exception e ){
            System.debug(e.getMessage());
        }
    }

    public static void Question8(){
        try{
            throwAException();
        }
        catch( Exception e ){
            System.debug('Rethrown Exception was catched');
            System.debug('Rethrown Exception Type : ' + e.getTypeName());
        }
    }

    public static void throwAException(){
        try{
            insert new Account();
        }
        catch(DmlException e){
            System.debug(e.getMessage());
            throw e;
        }
    }

    public static void Question9(String emailString){
        try{
            if( emailString == null || emailString.isEmpty() ){
                throw new InvalidDataException();
            }
        }
        catch( InvalidDataException e ){
            System.debug('Entered Email isn\'t a valid email');
        }
    }

}

