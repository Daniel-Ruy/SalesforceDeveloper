@isTest
global class AnimalLocatorMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');

        if(req.getEndpoint().contains('/1')) {
            res.setBody('{"animal":{"id":1,"name":"dog","eats":"dog food","says":"woof"}}');
            res.setStatusCode(200);
        } else if(req.getEndpoint().contains('/2')) {
            res.setBody('{"message":"Not found"}');
            res.setStatusCode(404);
        } else {
            res.setBody('{"animal":{"id":3,"name":"cat","eats":"cat food","says":"meow"}}');
            res.setStatusCode(200);
        }

        return res;
    }
}
