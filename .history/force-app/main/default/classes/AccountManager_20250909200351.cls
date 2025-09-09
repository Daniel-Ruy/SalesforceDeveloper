@RestResource(urlMapping='/AccountManager/')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        if(RestContext.response == null) {
            RestContext.response = new RestResponse();
        }

        String id = RestContext.request.params.get('id');

        if(String.isBlank(id)) {
            RestContext.response.statusCode = 400;
            RestContext.response.responseBody = Blob.valueOf('Missing ID');
            return null;
        }

            List<Account> accList = [SELECT Id, Name, (SELECT Id, LastName, Name FROM Contacts)
                                     FROM Account
                                     WHERE Id = :id
                                     LIMIT 1];

            if(accList.isEmpty()) {
                RestContext.response.statusCode = 404;
                RestContext.response.responseBody = Blob.valueOf('Account not found');
                return null;
            }

            return accList[0];

        
    }
}
