public virtual with sharing class Human {
    public Human() {
        System.debug('Human Class Constructor is called');
    }

    public void Walk(){
        System.debug('Human is walking');
    }

    public void speak(){
        System.debug('Human is speaking');
    }

}