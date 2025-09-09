public with sharing class LeadProcessor implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, LeadSource FROM Lead]);
    }
    public execute(Database.BatchableContext bc, List<Lead> leads){

    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch completed');
    }
}