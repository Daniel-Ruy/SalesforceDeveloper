@isTest
public with sharing class ProductZoningServiceTest {

    @isTest 
    static void getFlyZoneTest(){
        Product2  product = new Product2(Name = 'GenWatt Diesel 1000kW', ProductCode = 'GC1020', IsActive = True, Family = 'TestFamily');
        insert product;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('productCode', 'GC1060');
        req.headers.put('countryCode', 'US');
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();

        String result = ProductZoningService.getFlyZone();
        Test.stopTest();

        
    }

}