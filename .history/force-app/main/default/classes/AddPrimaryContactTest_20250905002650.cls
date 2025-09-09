@isTest
public with sharing class AddPrimaryContactTest {

    public setup(){
        for(i = 0; i< 50; i++){
            Account account = new Account(
                Name = 'Test Account ' + i
            );
            insert account;
        }
    }



    @isTest
    public AddPrimaryContactTest() {

    }
}