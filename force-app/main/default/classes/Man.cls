public with sharing class Man extends Human {
    public Man() {
        System.debug('Man class Constructor is called');
        Walk();
        speak();
    }

    // public void walk(){
    //     System.debug('Man is walking');
    // }

    // public void speak(){
    //     System.debug('Man is speaking');
    // }
}