@isTest
global  class AnimalLocatorMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        String id = req.getEndpoint().substring(req.getEndpoint().lastIndexOf('/') + 1);
        if(id == '1'){
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"Id":1,"name": "Dog"}');
            res.setStatusCode(200);
            return res;
        }else{
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"error": "Not found"}');
            res.setStatusCode(404);
            return res;
        }
    
    }
}