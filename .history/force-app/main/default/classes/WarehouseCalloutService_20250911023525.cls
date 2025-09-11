global with sharing class WarehouseCalloutService implements Queueable, Database.allowCallouts {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';


    public void execute(QueueableContext context){

        HttpRequest req = new HttpRequest();
        req.setEndpoint(WAREHOUSE_URL);
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if(res.getStatusCode() == 200){
            String responseBody = res.getBody();
            List<Map<String,Object>> items = (List<Map<String,Object>>)JSON.deserializeUntyped(responseBody);

            List<Product2> equipmentTpUpsert = new List<Product2>();
            For(Map<String,Object> i : items){
                Product2 equipmentTp = new Product2();
                
            }

        }

    }

    
}