public with sharing class LeadProcessor implements Database.Batchable<SObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // retorna os registros que serão processados
        return Database.QueryLocator('SELECT Id, LeadSource FROM Lead')
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        // processa cada lote de registros
    }

    public void finish(Database.BatchableContext bc) {
        // pós-processamento após todos os lotes
    }
}
