@RestResource(urlMapping='/AccountManager/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount(String id) {
        try{
            Account acc = [SELECT Id, Name, (SELECT Id, Name FROM Contacts WHERE AccountId =: id) FROM Account where id =: id];
            return acc;
        }catch(Exception e){
            return null;
        }
        
        
        
    }
}