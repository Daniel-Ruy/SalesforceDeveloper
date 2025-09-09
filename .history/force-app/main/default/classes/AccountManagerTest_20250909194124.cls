@isTest
public with sharing class AccountManagerTest {
    
    private static Account setup(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact ctt = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        insert ctt;
        Contact ctt2 = new Contact (LastName= 'Teste Contact 2', AccountId = acc.Id);
        insert ctt2;
        return acc;
    }
    
    @isTest
    static void accountManagerTest(){
        Account acc = setup();
        Test.startTest();
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/AccountManager';
        req.httpMethod = 'GET';
        req.params.put('id', acc.Id);
        RestContext.request = req;
        Account result = AccountManager.getAccount();
        Test.stopTest();
        
        System.assertNotEquals(null, result);
        System.assertEquals(acc.Id, result.Id);
        System.assertEquals(2, result.Contacts.size());
        System.assertEquals('Test Contact', result.Contacts[0].LastName);
        System.assertEquals('Teste Contact 2', result.Contacts[1].LastName);
        
        
        
    }
    
}