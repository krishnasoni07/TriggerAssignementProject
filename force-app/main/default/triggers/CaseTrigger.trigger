trigger CaseTrigger on Case (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        // CaseUtilityClass.setCaseNumberInAccountRecord( Trigger.new ); // Q.7
        CaseUtilityClass.setCaseNumberInAccountRecord(Trigger.new); // Q.33
    }
}