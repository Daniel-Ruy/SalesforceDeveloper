@isTest
public with sharing class DailyLeadProcessorTest {

    static void setup(){
        List<Lead> leadToCreate = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            leadToCreate.add(new Lead(
                LastName = 'Lead_' + i + '_' + String.valueOf(Math.abs(Crypto.getRandomInteger())),
                Status = 'Open - Not Contacted',
                Company = 'Company_' + i + '_' + String.valueOf(Math.abs(Crypto.getRandomInteger()))
            ));
        }
        insert leadToCreate;
    }

    @isTest
    static void DailyLeadProcessorTestMethod() {
        setup();
        test.startTest();
        DailyLeadProcessor job = new DailyLeadProcessor();
        job.execute(new SchedulableContext(){
            public String getTriggerId(){return '0';}
        });

        
    }
}
