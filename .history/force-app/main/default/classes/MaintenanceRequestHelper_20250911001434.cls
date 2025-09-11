public with sharing class MaintenanceRequestHelper {
    
    public static  List<Equipment_Maintenance_Item__c> equipmentMaintenanceItem(List<Case> lstCase){
        return  [SELECT Id, Maintenance_Request__c 
                FROM Equipment_Maintenance_Item__c 
                WHERE Maintenance_Request__c IN :lstMaintenanceRequest];
    }
    public static List<Equipment_Maintenance_Item__c> equipmentMaintenanceItemToCreate(List<Case> lstCase){

    }


    
    public static void updateMaintenanceRequest(List<Maintenance_Request__c> lstMaintenanceRequest) {
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItem = equipmentMaintenanceItem(lstMaintenanceRequest);

    }
}

//if(mr.Status == 'Closed' & mr.Type == 'Repair' || mr.Type == 'Routine Maintenance')