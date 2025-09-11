public with sharing class MaintenanceRequestHelper {
    
    public static  List<Equipment_Maintenance_Item__c> equipmentMaintenanceItem(List<Case> lstCase){
        return  [SELECT Id, Maintenance_Request__c,Equipment__c 
                FROM Equipment_Maintenance_Item__c 
                WHERE Maintenance_Request__c IN :lstMaintenanceRequest];
    }

    public static Date dtDueDate (List<Maintenance_Request__c> lstMaintenanceRequest){
        Number lowerValue;
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItem = equipmentMaintenanceItem(lstMaintenanceRequest);
        
        List<Product2> equip = [SELECT Id, Maintenance_Cycle__c 
        FROM Product2 
        WHERE Id IN :lstEquipmentMaintenanceItem];
        for(Product2 equipAtual : equip){
            if(equipAtual.Maintenance_Cycle__c < lowerValue || lowerValue == null){
                lowerValue = equipAtual.Maintenance_Cycle__c;
            }

        }
        return System.today().addDays(lowerValue);
    }

    public static void updateMaintenanceRequest(List<Maintenance_Request__c> lstMaintenanceRequest) {
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItem = equipmentMaintenanceItem(lstMaintenanceRequest);
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItemClone = new List<Equipment_Maintenance_Item__c>();
        List<Case> mrToCreate = new List<Case>();

        for(Case mr :lstMaintenanceRequest ){
            if(mr.Status == 'Closed' & mr.Type == 'Repair' || mr.Type == 'Routine Maintenance'){
                Case newMR = new Case();
                newMr.Subject = 'New Maintenance Request';
                newMr.Status = 'New';
                newMr.Type = 'Routine Maintenance';
                newMr.Date_Reported__c = System.today();
                newMr.Vehicle__c = mr.Vehicle__c;
                newMr.Date_Due__c = dtDueDate(lstMaintenanceRequest);
                mrToCreate.add(newMR);

            }
        }
        if (!mrToCreate.isEmpty()&& Schema.sObjectType.Case.isCreateable()){
            insert mrToCreate;
        }
    }
}

/*                for(Equipment_Maintenance_Item__c emi : lstEquipmentMaintenanceItem){
                    Equipment_Maintenance_Item__c emiClone = emi.clone(false, true, false, false);
                    emiClone.Maintenance_Request__c = mr.Id;
                    lstEquipmentMaintenanceItemClone.add(emiClone);
                }*/