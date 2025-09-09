@isTest
public class AnimalLocatorTest {

    @isTest
    static void testGetAnimalNameByIdValid() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(1); // retorna "dog"
        Test.stopTest();

        System.assertEquals('dog', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdNotFound() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(2); // retorna 404
        Test.stopTest();

        System.assertEquals('Error: 404', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdOther() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(3); // retorna "cat"
        Test.stopTest();

        System.assertEquals('cat', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdMissingAnimal() {
        // Mock que retorna JSON sem "animal" para testar fallback
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMock() {
            global HTTPResponse respond(HTTPRequest req) {
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                res.setBody('{}'); // JSON vazio
                return res;
            }
        });

        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(99);
        Test.stopTest();

        System.assertEquals('Error: invalid response', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdMissingName() {
        // Mock que retorna "animal" sem "name"
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMock() {
            global HTTPResponse respond(HTTPRequest req) {
                HttpResponse res = new HttpResponse();
                res.setStatusCode(200);
                res.setBody('{"animal":{"id":10}}'); // sem "name"
                return res;
            }
        });

        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(10);
        Test.stopTest();

        System.assertEquals('Error: name not found', animalName);
    }

    @isTest
    static void testGetAnimalNameByIdException() {
        // Mock que lança exceção
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMock() {
            global HTTPResponse respond(HTTPRequest req) {
                throw new CalloutException('Simulated exception');
            }
        });

        Test.startTest();
        String animalName = AnimalLocator.getAnimalNameById(123);
        Test.stopTest();

        System.assertEquals('Error: Exception', animalName);
    }
}
