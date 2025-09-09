public with sharing class AddPrimaryContact implements Queueable     {
    
    private Contact contact;
    private String billingState;
    
    public AddPrimaryContact(Contact contact, String billingState) {
        
        this.contact = contact;
        this.billingState = billingState;
        
    }
    public void execute(QueueableContext context) {

        List<Account> lstAccount =
            [SELECT Id, Name, BillingState 
            FROM Account 
            WHERE BillingState = :billingState 
            LIMIT 200];
        
        List<Contact> lstContactsToInsert = new List<Contact>();
        
        For(Account acc : lstAccount){
            
            Contact c = contact.clone();
            c.AccountId = acc.id;
            lstContactsToInsert.add(c);
        }
        insert lstContactsToInsert;
    }
}