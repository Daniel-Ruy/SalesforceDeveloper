@isTest
private with sharing class ParkLocatorTest {

    @isTest 
    static void testCallout(){
        test.setMock(WebServiceMock.class, new ParkServiceMock());
        String countryName = 'United States';
        List<String> parks = ParkLocator.country(countryName);
        System.Assert.areEqual(3, parks.size());

    }

}