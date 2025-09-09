@isTest
public with sharing class AccountManagerTest {
    
    // Setup de dados
    private static Account setup(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Contact ctt = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        Contact ctt2 = new Contact(LastName= 'Teste Contact 2', AccountId = acc.Id);
        insert new List<Contact>{ctt, ctt2};

        return acc;
    }
    
    // Teste de sucesso
    @isTest
    static void accountManagerSucessTest(){
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

    // Teste 404
    @isTest
    static void accountManager404Test(){
        Test.startTest();
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/AccountManager';
        req.httpMethod = 'GET';
        req.params.put('id', '001000000000000000'); // Id inexistente
        RestContext.request = req;

        Account result = AccountManager.getAccount();
        Test.stopTest();
        
        System.assertEquals(null, result);
        System.assertEquals(404, RestContext.response.statusCode);
        System.assertEquals('Account not found', RestContext.response.responseBody.toString());
    }

    // Teste 400 (opcional: id em branco)
    @isTest
    static void accountManager400Test(){
        Test.startTest();
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/AccountManager';
        req.httpMethod = 'GET';
        req.params.put('id', ''); // id vazio
        RestContext.request = req;

        Account result = AccountManager.getAccount();
        Test.stopTest();

        System.assertEquals(null, result);
        System.assertEquals(400, RestContext.response.statusCode);
        System.assertEquals('Missing ID', RestContext.response.responseBody.toString());
    }
}
