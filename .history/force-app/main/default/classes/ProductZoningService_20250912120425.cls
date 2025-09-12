@RestResource(urlMapping='/ProductZoning/*')
public with sharing class ProductZoningService {
    
    @HttpGet
    public static String getFlyZone(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String countryCode = RestContext.request.params.get('countryCode');
        String productCode = RestContext.request.params.get('productCode');

    }

}