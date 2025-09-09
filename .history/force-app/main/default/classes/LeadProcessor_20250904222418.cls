public with sharing class LeadProcessor implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Name, Email FROM Lead]);
    }
    public execute(Database.BatchableContext bc, List<Lead> leads){
        List<Contact> contacts = new List<Contact>();
        for(Lead lead : leads){
            Contact contact = new Contact();
            contact.LastName = lead.Name;
            contact.Email = lead.Email;
            contacts.add(contact);
        }
        insert contacts;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch completed');
    }
}