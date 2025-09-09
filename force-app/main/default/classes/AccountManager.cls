@RestResource(urlMapping='/AccountManager/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        String id = RestContext.request.params.get('id');
        try{
            Account acc = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account where id =: id];
            return acc;
        }catch(QueryException e){
            RestContext.response.statusCode = 404;
            RestContext.response.responseBody = Blob.valueOf('Account not found');
            return null;
        }catch(Exception e){
            RestContext.response.statusCode = 500;
            RestContext.response.responseBody = Blob.valueOf('Error: ' + e.getMessage());
            return null;
        }
            
    }
}