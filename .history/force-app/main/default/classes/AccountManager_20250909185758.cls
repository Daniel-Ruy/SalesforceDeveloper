@RestResource(urlMapping='/AccountManager/*')
global with sharing class AccountManager {
    @HttpGet
    global static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
        
    }
}