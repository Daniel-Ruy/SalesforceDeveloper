public with sharing class AccountProcessor {
    
    @future
    public static void  countContacts(List<Id> accoundIds) {
        
        if(Schema.sObjectType.Contact.isAccessible()) {
            
            List<Contact> contacts = [SELECT AccountId FROM Contact WHERE AccountId IN :accountIds];
        }
        if(Schema.sObjectType.Account.isAccessible()) {
            
            List<Account> accToUpdate = [SELECT Id FROM Account  WHERE Id IN :accountIds];
        }
        
        Map <Id, Integer> accountContactCount = new Map<Id, Integer>();
        for(AggregateResult ar :[SELECT AccountId, COUNT(Id) cnt FROM Contact WHERE AccountId IN :accoundIds GROUP BY AccountId]){
            accToUpdate.add(new Account(Id = (Id)ar.get('AccountId'), NumberOfContacts__c = (Integer)ar.get('cnt')));
            
        }

        if(!accToUpdate.isEmpty() && Schema.sObjectType.Account.isUpdateable()) {
            update accToUpdate;
        }
        
    }
    
}