public with sharing class AnimalLocator {

    public static String getAnimalNameById(Integer id) {
        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
            req.setMethod('GET');

            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                Map<String,Object> mapRes = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                if (mapRes.containsKey('animal')) {
                    Map<String,Object> animalMap = (Map<String,Object>)mapRes.get('animal');
                    if(animalMap.containsKey('name')){
                        return (String)animalMap.get('name');
                    } else {
                        return 'Error: name not found';
                    }
                } else {
                    return 'Error: invalid response';
                }
            } else {
                return 'Error: ' + res.getStatusCode();
            }
        } catch (Exception e) {
            return 'Error: Exception';
        }
    }
}
