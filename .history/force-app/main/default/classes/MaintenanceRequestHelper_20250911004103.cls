public with sharing class MaintenanceRequestHelper {
    
    public static  List<Equipment_Maintenance_Item__c> equipmentMaintenanceItem(List<Case> lstCase){
        return  [SELECT Id, Maintenance_Request__c,Equipment__c 
                FROM Equipment_Maintenance_Item__c 
                WHERE Maintenance_Request__c IN :lstMaintenanceRequest];
    }

    public static Date dtDueDate (List<Maintenance_Request__c> lstMaintenanceRequest){
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItem = equipmentMaintenanceItem(lstMaintenanceRequest);
        
        List<Product2> equip = [SELECT Id, Maintenance_Cycle__c 
        FROM Product2 
        WHERE Id IN :lstEquipmentMaintenanceItem];
    }

    public static void updateMaintenanceRequest(List<Maintenance_Request__c> lstMaintenanceRequest) {
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItem = equipmentMaintenanceItem(lstMaintenanceRequest);
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItemClone = new List<Equipment_Maintenance_Item__c>();
        List<Case> mrToCreate = new List<Case>();

        for(Case mr :lstMaintenanceRequest ){
            if(mr.Status == 'Closed' & mr.Type == 'Repair' || mr.Type == 'Routine Maintenance'){
                for(Equipment_Maintenance_Item__c emi : lstEquipmentMaintenanceItem){
                    Equipment_Maintenance_Item__c emiClone = emi.clone(false, true, false, false);
                    emiClone.Maintenance_Request__c = mr.Id;
                    lstEquipmentMaintenanceItemClone.add(emiClone);
                }
                Case newMR = new Case();
                newMr.Subject = 'New Maintenance Request';
                newMr.Status = 'New';
                newMr.Type = 'Routine Maintenance';
                newMr.Date_Reported__c = System.today();
                newMr.Vehicle__c = mr.Vehicle__c;

                mrToCreate.add(newMR);

            }
        }
    }
}
