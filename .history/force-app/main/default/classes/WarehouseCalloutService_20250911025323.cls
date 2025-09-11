global with sharing class WarehouseCalloutService implements Queueable, Database.AllowCallouts {

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

            List<Product2> equipmentToUpsert = new List<Product2>();
            For(Map<String,Object> i : items){
                Product2 equipment = new Product2();
                equipment.Replacement_Part__c = (Boolean)i.get('replacement');
                equipment.Current_Inventory__c = (Integer)i.get('quantity');
                equipment.Name = (String)i.get('name');
                equipment.Maintenance_Cycle__c = (Decimal)i.get('maintenanceperiod');
                equipment.Lifespan_Months__c = (Decimal)i.get('lifespan');
                equipment.Cost__c = (Decimal)i.get('cost');
                equipment.Warehouse_SKU__c = (String)i.get('sku');

                equipmentToUpsert.add(equipment);
                
                
            }

            upsert equipmentToUpsert Warehouse_SKU__c;

        }else{
            System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
        }

    }

    
}