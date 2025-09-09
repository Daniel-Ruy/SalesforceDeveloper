public with sharing class DailyLeadProcesso implements Schedulable {

    public void execute(SchedulableContext sc) {
        List<Lead> leads = [SELECT Id, LeadSource FROM Lead];
        for(Lead ld : leads){
            ld.LeadSource = 'Dreamforce';
        }
        Database.update(leads, false);
    }

}