public with sharing class MaintenanceRequestHelper {
    
    public static void updateMaintenanceRequest(List<Maintenance_Request__c> lstMaintenanceRequest) {
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItem =
            [SELECT Id, Maintenance_Request__c 
            FROM Equipment_Maintenance_Item__c 
            WHERE Maintenance_Request__c IN :lstMaintenanceRequest];
            
        for(Case mr : lstMaintenanceRequest){
            if(mr.Status == 'Closed' & mr.Type == 'Repair' || mr.Type == 'Routine Maintenance'){
                
            }
            
        }
        
        
    }
    
}