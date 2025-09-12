@RestResource(urlMapping='/ProductZoning/*')
global with sharing class ProductZoningService {
    
    @HttpGet
    global static String getFlyZone(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String countryCode = req.headers.get('countryCode');
        if(String.isEmpty(countryCode)){
            countryCode = 'US';
        }
        String productCode = req.params.get('productCode');
        if(String.isEmpty(productCode)){
            return 'ProductCode is missing or doesn\'t exist';
        }
        
    }

}