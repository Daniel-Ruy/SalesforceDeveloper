public with sharing class AnimalLocator {
    
    public static String getAnimalNameById(Integer id ) {
        
        String url = 'https://th-apex-http-callout.herokuapp.com/animals/' + id;
        
        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200){
            Map<String,Object> responseMap = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            return (String)responseMap.get('name');
        }else{
            return 'Error: ' + response.getStatusCode();
        }
        
        
        
    }
}