public with sharing class LeadProcessor implements Database.Batchable<SObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // retorna os registros que serão processados
        return Database.QueryLocator('SELECT Id, LeadSource FROM Lead')
    }

    public void execute(Database.BatchableContext bc, List<Lead> leadQuery) {
        For(Lead lead : leadQuery) {
            lead.LeadSource = 'Dreamforce';
        }
        Database.update(leadQuery, false);
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Finished Batch ' )
    }
}
