@isTest
private  class  AnimalLocatorTest {
    
    @isTest
    static void getAnimalNameByIdTest() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        test.start();
        AnimalLocator locator = new AnimalLocator();
        String animalName = locator.getAnimalNameById(1);
        System.Assert.areEqual('Dog', animalName);
        
    }
    
    
}