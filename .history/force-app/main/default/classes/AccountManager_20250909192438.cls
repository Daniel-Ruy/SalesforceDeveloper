@RestResource(urlMapping='/AccountManager/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        String id = RestContext.request.params.get('id');
        try{
            Account acc = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account where id =: id];
            return acc;
        }catch(QueryException e){
            throw new RestException('Account not found');
        }
            
    }
}