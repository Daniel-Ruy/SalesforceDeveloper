@RestResource(urlMapping='/AccountManager/*')
global with sharing class AccountManager {
    @HttpGet
    global static List<Account> getAccounts(String id) {
        List<Account> lstAccounts = [SELECT Id, Name, BillingState FROM Account WHERE Id = :id];
        return lstAccounts;
        
    }
}