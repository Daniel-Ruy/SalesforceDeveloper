@isTest
public with sharing class ProductZoningServiceTest {
    
    private static Product2 setup(){
        Product2  product = new Product2(Name = 'Test Product', ProductCode = 'GC1020', IsActive = True, Family = 'Fixed-Wing');
        insert product;
        return product;
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
        System.assertEquals('Regulated',  result);
        
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
        System.assertEquals('Regulated',  result);
    }
    @isTest
    static void getFlyZoneTestWithInvalidParam(){
        setup();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('productCode', '1234');
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String result = ProductZoningService.getFlyZone();
        Test.stopTest();
        System.assertEquals('ProductCode is missing or doesn\'t exist',  result);
    }
    @isTest
    static void getFlyZoneTestWithNullParam(){
        setup();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductZoning/';
        //req.addParameter('productCode', '1234');
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String result = ProductZoningService.getFlyZone();
        Test.stopTest();
        System.assertEquals('ProductCode is missing or doesn\'t exist',  result);
    }
    
}