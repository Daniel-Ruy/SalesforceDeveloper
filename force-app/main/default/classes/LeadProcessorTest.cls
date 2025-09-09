@isTest
public with sharing class LeadProcessorTest {
    
    static void setup(){
        
        List<Lead> leadsToCreate = new List<Lead>();
        For(Integer i = 0; i < 200;){
            
            leadsToCreate.add(new Lead(
                LastName = 'Lead_' + i + '_' + String.valueOf(Math.abs(Crypto.getRandomInteger())),
                Status = 'Open - Not Contacted',
                Company = 'Company_' + i + '_' + String.valueOf(Math.abs(Crypto.getRandomInteger()))
                ));
            i++;
        }
        
        insert leadsToCreate;
        
    }
    
    @isTest
    static void testLeadProcessor(){
        setup();
        Test.startTest();
        Id batchId = Database.executeBatch(new LeadProcessor(), 200);
        Test.stopTest();
        List<Lead> leads = [SELECT Id, LeadSource FROM Lead];
        System.Assert.areEqual(200, leads.size());
        for(Lead ld : leads){
            System.Assert.areEqual('Dreamforce', ld.LeadSource);
            System.debug(ld.LeadSource);
        }
    }
    
}