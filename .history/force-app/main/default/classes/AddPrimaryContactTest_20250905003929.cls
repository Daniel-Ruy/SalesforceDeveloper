@isTest
public with sharing class AddPrimaryContactTest {
    
    static void setup(){
        List<Account> lstAccountsToInsert = new List<Account>();
        for(i = 0; i< 50; i++){
            Account account = new Account(
                Name = 'Test Account ' + i,
            BillingState = 'CA');
            lstAccountsToInsert.add(account);
            
            
        }
        for(i = 0; i< 50; i++){
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
        
        setup();
        Test.startTest();
        AddPrimaryContact addPrimaryContact = new AddPrimaryContact(ctt, 'CA');
        Test.stopTest();
        List<Account> lstAccount = [SELECT Id, Name, BillingState FROM Account WHERE BillingState = 'CA'];
        List<Contact> lstContactsInserted = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :lstAccount];
        System.assertEquals(50, ctt);
        
    }
}