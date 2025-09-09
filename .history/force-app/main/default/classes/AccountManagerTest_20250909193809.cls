
@isTest
public with sharing class AccountManagerTest {

     private static Account setup(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact ctt = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        insert ctt;
        Contact ctt2 = new Contact (LastName= 'Teste Contact 2', AccountId = acc.Id);
        insert ctt2;

    }

    @isTest
    static void accountManagerTest(){
        setup();
        Test.startTest();
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/AccountManager';
        req.httpMethod = 'GET';
        RestContext.request = req;
        Account result = AccountManager.getAccount();
        Test.stopTest();



    }

}