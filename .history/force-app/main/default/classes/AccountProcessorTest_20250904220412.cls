
@isTest 
public with sharing class AccountProcessorTest {


    static @IsTest
    static void accountProcessorTest(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact ctt = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        insert ctt;
        AccountProcessor.countContacts(new List<Id>{acc.Id});
        
        Test.startTest();

        Account accResult = [SELECT Id, Name, Number_Of_Contacts__c FROM Account WHERE Id = :acc.Id];

        System.Assert.areEqual(1, accResult.Number_Of_Contacts__c);

        Test.stopTest();
        
    }
}