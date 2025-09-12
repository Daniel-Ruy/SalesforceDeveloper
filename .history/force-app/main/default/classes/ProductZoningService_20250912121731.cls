@RestResource(urlMapping='/ProductZoning/*')
global with sharing class ProductZoningService {
    
    @HttpGet
    global static String getFlyZone(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
    }

}