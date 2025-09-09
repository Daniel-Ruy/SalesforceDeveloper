public with sharing class AccountProcessor {

    @future
    public static void  countContacts(List<Id> accoundIds) {

        if(Schema.sObjectType.Contact.isAccessible()) {

            List<Contact> contacts = [SELECT AccountId FROM Contact WHERE AccountId IN :accountIds];
        }

        Map <Id, Integer> accountContactCount = new Map<Id, Integer>();
        for(AggregateResult ar :[SELECT AccountId, COUNT(Id) cnt FROM Contact WHERE AccountId IN :accoundIds GROUP BY AccountId]){

            accountContactCount.put((Id)ar.get('AccountId'), (Integer)ar.get('cnt'));
        }
        
    }

}