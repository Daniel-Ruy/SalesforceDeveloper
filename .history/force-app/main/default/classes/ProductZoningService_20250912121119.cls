@RestResource(urlMapping='/ProductZoning/*')
global with sharing class ProductZoningService {
    
    @HttpGet
    global static String getFlyZone(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
         //String countryCode = RestContext.request.params.get('countryCode');
        String productCode = RestContext.request.params.get('productCode');

    }

}