@isTest
public with sharing class AddPrimaryContactTest {
    
    static void setup(){
        List<Account> lstAccountsToInsert = new List<Account>();
        for(Integer i = 0; i< 50; i++){
            Account account = new Account(
                Name = 'Test Account ' + i,
                BillingState = 'CA',
                BillingCountry = 'USA'
            );
            lstAccountsToInsert.add(account);
        }
        for(Integer i = 50; i< 100; i++){
            Account account = new Account(
                Name = 'Test Account ' + i,
                BillingState = 'NY',
                BillingCountry = 'USA'
            );
            lstAccountsToInsert.add(account);
        }
        insert lstAccountsToInsert;
        List<Account> accountToCreateContact = [SELECT Id FROM Account WHERE BillingState = 'NY' LIMIT 1];
        Contact ctt = new Contact(LastName = 'Test Contact', AccountId = accountToCreateContact[0].Id);
        insert ctt;
    }
    
    @isTest
    static void addPrimaryContactTest() {
        setup();
        List<Contact> searchContact = [SELECT Id, AccountId FROM Contact WHERE LastName = 'Test Contact' LIMIT 1];
        Test.startTest();
        AddPrimaryContact job = new AddPrimaryContact(searchContact[0], 'CA');
        System.enqueueJob(job);
        Test.stopTest();
        List<Account> lstAccount = [SELECT Id FROM Account WHERE BillingState = 'CA'];
        List<Contact> lstContactsInserted = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :lstAccount];
        System.assertEquals(50, lstContactsInserted.size());
    }
}
