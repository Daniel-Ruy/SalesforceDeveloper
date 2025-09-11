public with sharing class MaintenanceRequestHelper {
    
    public static  List<Equipment_Maintenance_Item__c> EquipmentMaintenanceItem(List<Case> lstCase){
        return  [SELECT Id, Maintenance_Request__c 
                FROM Equipment_Maintenance_Item__c 
                WHERE Maintenance_Request__c IN :lstMaintenanceRequest];
    }


    
    public static void updateMaintenanceRequest(List<Maintenance_Request__c> lstMaintenanceRequest) {
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItem = EquipmentMaintenanceItem(lstMaintenanceRequest);

        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItemToCreate = new List<Equipment_Maintenance_Item__c>();
        for(Case mr : lstMaintenanceRequest){
            
            {
                
                for(Equipment_Maintenance_Item__c emi : lstEquipmentMaintenanceItem){
                    
                }
                
            }
        }
    }
}