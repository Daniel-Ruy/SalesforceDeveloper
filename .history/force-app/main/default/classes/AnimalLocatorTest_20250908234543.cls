@isTest
private class AnimalLocatorTest {

    @isTest
    static void testGetAnimalNameById() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        Test.startTest();

        String animalName = AnimalLocator.getAnimalNameById(1);
        Test.stopTest();

        System.assertEquals('Dog', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdWithInvalidId() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        Test.startTest();

        String animalName = AnimalLocator.getAnimalNameById(10000000000000000000000000000000);
        Test.stopTest();

        System.assertEquals('Error: 404', animalName);
    }
}
