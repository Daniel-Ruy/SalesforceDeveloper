@RestResource(UrlMapping='/account/*')
global class AccountManager {
    @HttpGet
    global static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }
}