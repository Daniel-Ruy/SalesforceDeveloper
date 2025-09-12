@isTest
public with sharing class ProductZoningServiceTest {

    @isTest 
    static void getFlyZoneTest(){
        Product2  product = new Product2(Name = 'GenWatt Diesel 1000kW', ProductCode = 'GC1060', IsActive = True, Family = 'Fixed-Wing');
        insert product;
        
    }

}