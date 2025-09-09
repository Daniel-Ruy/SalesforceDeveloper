@isTest
public with sharing class AddPrimaryContactTest {

    public setup(){
        List<Account> lstAccountsToInsert = new List<Account>();
        for(i = 0; i< 50; i++){
            Account account = new Account(
                Name = 'Test Account ' + i,
                BillingState = 'CA');
                lstAccountsToInsert.add(account);
            
            
        }
    }



    @isTest
    public AddPrimaryContactTest() {

    }
}