@isTest
public with sharing class ProductZoningServiceTest {
    
     private static Product2 setup(){
        Product2  product = new Product2(Name = 'Test Product', ProductCode = 'GC1020', IsActive = True, Family = 'TestFamily');
        insert product;
         return product;
    }

    private static void setupReqRes(){
        RestRequest = new RestRequest();
        RestResponse = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
    }
    
    @isTest
    static void getFlyZoneTestWithHeader(){
        setup();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('productCode', 'GC1020');
        req.headers.put('countryCode', 'US');
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String result = ProductZoningService.getFlyZone();
        Test.stopTest();
        System.assertEquals('Confirm with the local authorities',  result);
        
    }
    @isTest
    static void getFlyZoneTestWithoutHeader(){
        setup();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('productCode', 'GC1020');
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String result = ProductZoningService.getFlyZone();
        Test.stopTest();
        System.assertEquals('Confirm with the local authorities',  result);
    }
     static void getFlyZoneTestWithInvalidParam(){
        setup();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('productCode', 'GC1020');
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String result = ProductZoningService.getFlyZone();
        Test.stopTest();
        System.assertEquals('Confirm with the local authorities',  result);
    }
    
}