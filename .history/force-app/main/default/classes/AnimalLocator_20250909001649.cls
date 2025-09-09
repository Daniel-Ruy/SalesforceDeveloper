public with sharing class AnimalLocator {

    public static String getAnimalNameById(Integer id) {
        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
            req.setMethod('GET');

            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                return (String) result.get('animal');
            } else {
                return 'Error: ' + res.getStatusCode();
            }
        } catch (Exception e) {
            return 'Error: Exception';
        }
    }
}
