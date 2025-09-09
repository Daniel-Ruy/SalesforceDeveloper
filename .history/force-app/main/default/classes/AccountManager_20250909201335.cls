@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        if(RestContext.response == null) {
            RestContext.response = new RestResponse();
        }

        String uri = RestContext.request.requestURI;
        String accountId = uri.substringBetween('/Accounts/', '/contacts');

        if(String.isBlank(accountId)) {
            RestContext.response.statusCode = 400;
            RestContext.response.responseBody = Blob.valueOf('Missing Account ID');
            return null;
        }

        List<Account> accList = [SELECT Id, Name, (SELECT Id, Name FROM Contacts)
                                 FROM Account
                                 WHERE Id = :accountId
                                 LIMIT 1];

        if(accList.isEmpty()) {
            RestContext.response.statusCode = 404;
            RestContext.response.responseBody = Blob.valueOf('Account not found');
            return null;
        }

        return accList[0];
    }
}
