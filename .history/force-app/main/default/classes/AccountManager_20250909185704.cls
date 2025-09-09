@RestResource(UrlMapping='/account/*')
global with sharing class AccountManager {
    @HttpGet
    global static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }
}