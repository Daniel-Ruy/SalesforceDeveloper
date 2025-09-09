public with sharing class AddPrimaryContact implements Queueable     {
    

    public AddPrimaryContact(Contact contact, String billingState) {

        this.contact = contact;
        this.billingState = billingState;

    }
}