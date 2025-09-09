@isTest
global  class AnimalLocatorMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest req) {

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"Id":1,"name": "Dog"}');
        res.setStatusCode(200);
        return res;
    }
}