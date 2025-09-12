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
        if(String.isEmpty(productCode) && productCode == null){
            return 'ProductCode is missing or doesn\'t exist';
        }
        
        Product2 product = [SELECT Id,Family FROM Product2 WHERE Name = :productCode LIMIT 1];
        
        List<Product_Geo_Mapping__mdt> productGeoMapping =
            [SELECT Id, Permissible_Fly_Zone__c 
            FROM  Product_Geo_Mapping__mdt
            WHERE Product_Family__c = : product.Family
            AND Country_Code__c = :countryCode
            LIMIT 1];

            if(!productGeoMapping.isEmpty()){
                return productGeoMapping[0].Permissible_Fly_Zone__c;


    }  
}