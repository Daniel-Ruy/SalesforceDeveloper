public with sharing class LeadProcessor implements Database.Batchable<SObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.QueryLocator('SELECT Id, LeadSource FROM Lead');
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Database.SaveResult> results = Database.update(leadQuery, false);
        For(Lead lead : results) {
            lead.LeadSource = 'Dreamforce';

        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Finished Batch ' );
    }
}
