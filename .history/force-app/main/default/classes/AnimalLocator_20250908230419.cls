public with sharing class AnimalLocator {

    public getAnimalNameById(Integer number ) {

        String url = 'https://th-apex-http-callout.herokuapp.com/animals/' + number;
        
        Http htpp = new htpp();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');

        HttpResponse response = htpp.send(request);
        return res.getBody();



    }
}