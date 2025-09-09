@isTest
public class AnimalLocatorTest {

    @isTest
    static void testGetAnimalNameByIdValid() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(1);
        Test.stopTest();
        System.assertEquals('dog', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdNotFound() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(2);
        Test.stopTest();
        System.assertEquals('Error: 404', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdOther() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(3);
        Test.stopTest();
        System.assertEquals('cat', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdMissingName() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(10);
        Test.stopTest();
        System.assertEquals('Error: name not found', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdMissingAnimal() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(99);
        Test.stopTest();
        System.assertEquals('Error: invalid response', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdException() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(123);
        Test.stopTest();
        System.assertEquals('Error: Exception', animalName);
    }
}
