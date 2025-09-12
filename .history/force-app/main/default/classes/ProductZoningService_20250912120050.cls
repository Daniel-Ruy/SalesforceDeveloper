@RestResource(urlMapping='/ProductZoning/*')
public with sharing class ProductZoningService {
    
    @HttpGet
    public static String getFlyZone(String countryCode){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String product = req.requestURI.substringAfter('/ProductZoning/');

    }

}