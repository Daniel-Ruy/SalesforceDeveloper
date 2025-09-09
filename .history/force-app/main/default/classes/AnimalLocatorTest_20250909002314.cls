@isTest
global class AnimalLocatorMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');

        if(req.getEndpoint().contains('/1')) {
            res.setBody('{"animal":{"id":1,"name":"dog"}}');
            res.setStatusCode(200);
        } else if(req.getEndpoint().contains('/2')) {
            res.setBody('{"message":"Not found"}');
            res.setStatusCode(404);
        } else if(req.getEndpoint().contains('/3')) {
            res.setBody('{"animal":{"id":3,"name":"cat"}}');
            res.setStatusCode(200);
        } else if(req.getEndpoint().contains('/10')) {
            res.setBody('{"animal":{"id":10}}'); // sem "name"
            res.setStatusCode(200);
        } else if(req.getEndpoint().contains('/99')) {
            res.setBody('{}'); // sem "animal"
            res.setStatusCode(200);
        } else {
            throw new CalloutException('Simulated exception');
        }

        return res;
    }
}
