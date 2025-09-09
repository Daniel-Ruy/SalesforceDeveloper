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
    static void testGetAnimalNameByIdInvalid() {
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
}
