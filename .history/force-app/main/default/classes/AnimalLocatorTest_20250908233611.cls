@isTest
private  class  AnimalLocatorTest {
    
    @isTest
    static void getAnimalNameByIdTest() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        test.start();
        AnimalLocator locator = new AnimalLocator();
        String animalName = locator.getAnimalNameById(1);
        Test.stopTest();
        System.Assert.areEqual('Dog', animalName);
        System.debug(animalName);
        
    }
    
    
}