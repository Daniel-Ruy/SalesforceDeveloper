public with sharing class LeadProcessor implements Database.Batchable<SObject>, Database.Stateful {

    public Database.QueryLocator start (Database.BatchableContext bc) {
        return  DataBase.getQueryLocator([SELECT Id, LeadSource FROM Lead]);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        for (SObject so : scope) {
            Lead l = (Lead)so; 
            l.LeadSource = 'Dreamforce';
        }
        Database.update(scope, false);
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Finished Batch. batchId = ' + bc.getJobId());
    }
}
