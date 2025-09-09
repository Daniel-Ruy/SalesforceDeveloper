public with sharing class AddPrimaryContact implements Queueable     {
    
    private Contact contact;
    private String billingState;

    public AddPrimaryContact(Contact contact, String billingState) {

        this.contact = contact;
        this.billingState = billingState;

    }
}