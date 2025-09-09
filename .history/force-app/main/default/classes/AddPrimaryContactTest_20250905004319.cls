@isTest
public with sharing class AddPrimaryContactTest {
    
    static void setup(){
        List<Account> lstAccountsToInsert = new List<Account>();
        for(Integer i = 0; i< 50; i++){
            Account account = new Account(
                Name = 'Test Account ' + i,
            BillingState = 'CA');
            lstAccountsToInsert.add(account);
            
            
        }
        for(Integer i = 50; i< 100; i++){
            Account account = new Account(
                Name = 'Test Account ' + i,
            BillingState = 'NY');
            lstAccountsToInsert.add(account);
            
            
        }
        
        insert lstAccountsToInsert;
        Contact ctt = new Contact(LastName = 'Test Contact', AccountId = new Account(Name = 'Test Account').Id());
        insert ctt;
    }
    
    
    
    @isTest
    public AddPrimaryContactTest() {
        List<Contact>searchContact = [SELECT Id, AccountId FROM Contact WHERE LastName = 'Test Contact'];
        
        setup();
        Test.startTest();
        AddPrimaryContact addPrimaryContact = new AddPrimaryContact(searchContact[0], 'CA');
        Test.stopTest();
        List<Account> lstAccount = [SELECT Id, Name, BillingState FROM Account WHERE BillingState = 'CA'];
        List<Contact> lstContactsInserted = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :lstAccount];
        System.assertEquals(50, ctt);
        
    }
}