@isTest
public class DailyLeadProcessorTest {

    static void setup(){
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            leads.add(new Lead(
                LastName = 'Lead_' + i + '_' + String.valueOf(Math.abs(Crypto.getRandomInteger())),
                Status = 'Open - Not Contacted',
                Company = 'Company_' + i + '_' + String.valueOf(Math.abs(Crypto.getRandomInteger()))
            ));
        }
        insert leads;
    }

    @isTest
    static void testDailyLeadProcessor() {
        setup();

        Test.startTest();

        String cronExp = '0 0 0 * * ?'; // agendado para rodar à meia-noite, mas no teste roda imediatamente
        System.schedule('Daily Lead Processor Test', cronExp, new DailyLeadProcessor());

        Test.stopTest();

    }
}
