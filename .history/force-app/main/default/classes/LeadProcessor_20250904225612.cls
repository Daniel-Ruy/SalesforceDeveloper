public with sharing class LeadProcessor implements Database.Batchable<Lead>, Database.Stateful {

    public final String Query = 'SELECT Id, LeadSource FROM Lead';
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(Query);
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> scope) {
        for(Lead lead : scope) {
            lead.LeadSource = 'Dreamforce';
            
        }
        Database.update(scope, false);
    }
    
    public void finish(Database.BatchableContext bc) {
        System.debug('Finished Batch ' + 'batchId =  ' + bc.getJobId());
        
    }
}