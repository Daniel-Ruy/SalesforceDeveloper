@isTest
private  class  AnimalLocatorTest {
    
    @isTest
    static void getAnimalNameByIdTest() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        Test.startTest();
        AnimalLocator locator = new AnimalLocator();
        String animalName = AnimalLocator.getAnimalNameById(1);
        Test.stopTest();
        System.Assert.areEqual('Dog', animalName);
        System.debug(animalName);
        
    }
    
    
}
@isTest
private class AnimalLocatorTest {

    @isTest
    static void testGetAnimalNameById() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(1);
        Test.stopTest();

        System.assertEquals('chicken', animalName);
    }
}
