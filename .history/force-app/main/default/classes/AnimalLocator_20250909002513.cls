public with sharing class AnimalLocator {

    public static String getAnimalNameById(Integer id) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        req.setMethod('GET');

        HttpResponse res = http.send(req);

        Map<String,Object> mapRes = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        Map<String,Object> animalMap = (Map<String,Object>)mapRes.get('animal');
        return (String)animalMap.get('name');
    }
}
