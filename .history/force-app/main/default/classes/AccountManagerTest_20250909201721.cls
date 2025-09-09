@isTest
public with sharing class AccountManagerTest {

    private static Account setupAccount(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Contact c1 = new Contact(LastName = 'Contact One', AccountId = acc.Id);
        Contact c2 = new Contact(LastName = 'Contact Two', AccountId = acc.Id);
        insert new List<Contact>{c1, c2};

        return acc;
    }

    @isTest
    static void testAccountManagerSuccess(){
        Account acc = setupAccount();

        Test.startTest();
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/Accounts/' + acc.Id + '/contacts';
        req.httpMethod = 'GET';
        RestContext.request = req;

        Account result = AccountManager.getAccount();
        Test.stopTest();

        System.assertNotEquals(null, result);
        System.assertEquals(acc.Id, result.Id);
        System.assertEquals(2, result.Contacts.size());
        System.assertEquals('Contact One', result.Contacts[0].LastName);
        System.assertEquals('Contact Two', result.Contacts[1].LastName);
    }

    @isTest
    static void testAccountManager404(){
        Test.startTest();
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/Accounts/001000000000000000/contacts';
        req.httpMethod = 'GET';
        RestContext.request = req;

        Account result = AccountManager.getAccount();
        Test.stopTest();

        System.assertEquals(null, result);
        System.assertEquals(404, RestContext.response.statusCode);
        System.assertEquals('Account not found', RestContext.response.responseBody.toString());
    }

    @isTest
    static void testAccountManager400(){
        Test.startTest();
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/Accounts//contacts';
        req.httpMethod = 'GET';
        RestContext.request = req;

        Account result = AccountManager.getAccount();
        Test.stopTest();

        System.assertEquals(null, result);
        System.assertEquals(400, RestContext.response.statusCode);
        System.assertEquals('Missing Account ID', RestContext.response.responseBody.toString());
    }
}
