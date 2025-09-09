public with sharing class AccountProcessor {

    @future
    public static void  countContacts(List<Id> accoundIds) {
        List<Contact> contacts = [SELECT AccountId FROM Contact WHERE AccountId IN :accoundIds];
        Map <Id, Integer> accountContactCount = new Map<Id, Integer>();

        for(AggregateResult ar :[SELECT AccountId, COUNT(Id) cnt FROM Contact WHERE AccountId IN :accoundIds GROUP BY AccountId]){
            
        }

    }
}