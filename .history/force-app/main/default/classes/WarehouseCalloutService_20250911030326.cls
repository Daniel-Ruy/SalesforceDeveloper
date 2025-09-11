global with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts {
    
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    public void execute(QueueableContext context) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(WAREHOUSE_URL);
        req.setMethod('GET');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if (res.getStatusCode() == 200) {
            String responseBody = res.getBody();
            
            List<Map<String, Object>> items =
                (List<Map<String, Object>>) JSON.deserializeUntyped(responseBody);
            
            List<Product2> productsToUpsert = new List<Product2>();
            
            for (Map<String, Object> i : items) {
                Product2 p = new Product2();
                p.ProductCode = (String) i.get('sku');
                p.Name = (String) i.get('name');
                p.IsActive = true;
                p.Replacement_Part__c   = (Boolean) i.get('replacement');
                p.Current_Inventory__c  = (Integer) i.get('quantity');
                p.Maintenance_Period__c = (Integer) i.get('maintenanceperiod');                p.Lifespan_Months__c    = (Integer) i.get('lifespan');
                p.Cost__c               = (Decimal) i.get('cost');
                
                productsToUpsert.add(p);
            }    
            upsert productsToUpsert Product2.ProductCode;
        }
    }
}