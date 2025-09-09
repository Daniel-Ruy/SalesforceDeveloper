
@isTest
public with sharing class AccountManagerTest {

    static void setup(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;)
    }

}