@isTest
public with sharing class AccountProcessorTest {
    
    @isTest
    static void countContactsTest(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact ctt = new Contact(LastName = 'Test Contact', AccountId = acc.Id);
        insert ctt;
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{acc.Id});
        Test.stopTest();
        
        
        Account accResult = [SELECT Id, Name, Number_Of_Contacts__c FROM Account WHERE Id = :acc.Id];
        
        System.Assert.areEqual(1, accResult.Number_Of_Contacts__c);
        
        
        
    }
}