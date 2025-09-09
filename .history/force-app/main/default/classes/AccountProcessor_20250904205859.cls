public with sharing class AccountProcessor {

    @future
    public static void  countContacts(List<Id> accoundIds) {
        List<Contact> contacts = [SELECT AccountId FROM Contact WHERE AccountId IN :accoundIds];
        
    }
}