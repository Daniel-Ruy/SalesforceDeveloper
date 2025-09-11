public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> triggerCases) {
        updateMaintenanceRequest(triggerCases);
    }
    
    public static List<Equipment_Maintenance_Item__c> equipmentMaintenanceItem(List<Case> lstCase){
        return [SELECT Id, Maintenance_Request__c, Equipment__c 
                FROM Equipment_Maintenance_Item__c 
                WHERE Maintenance_Request__c IN :lstCase];
    }
    
    public static Date dtDueDate(Case actualCase){
        Integer lowerValue;
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItem = [
            SELECT Equipment__c 
            FROM Equipment_Maintenance_Item__c 
            WHERE Maintenance_Request__c = :actualCase.Id
        ];
        
        Set<Id> equipId = new Set<Id>();
        for(Equipment_Maintenance_Item__c emi : lstEquipmentMaintenanceItem){
            equipId.add(emi.Equipment__c);
        }
        
        List<Product2> equip = [
            SELECT Maintenance_Cycle__c 
            FROM Product2 
            WHERE Id IN :equipId
        ];
        
        for(Product2 equipAtual : equip){
            if(equipAtual.Maintenance_Cycle__c < lowerValue || lowerValue == null){
                lowerValue = equipAtual.Maintenance_Cycle__c;
            }
        }
        return System.today().addDays(lowerValue);
    }
    
    public static void createEquipmentMaintenanceItem(List<Case> newCases, List<Case> originalCases){
        // Mapa de CaseId original → lista de EMIs
        Map<Id, List<Equipment_Maintenance_Item__c>> caseToEMIs = new Map<Id, List<Equipment_Maintenance_Item__c>>();
        
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItem = equipmentMaintenanceItem(originalCases);
        
        for(Equipment_Maintenance_Item__c emi : lstEquipmentMaintenanceItem){
            if(!caseToEMIs.containsKey(emi.Maintenance_Request__c)){
                caseToEMIs.put(emi.Maintenance_Request__c, new List<Equipment_Maintenance_Item__c>());
            }
            caseToEMIs.get(emi.Maintenance_Request__c).add(emi);
        }
        
        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItemClone = new List<Equipment_Maintenance_Item__c>();
        
        for(Integer i = 0; i < newCases.size(); i++){
            Case newMR = newCases[i];
            Case originalMR = originalCases[i]; // Assumindo que a lista tem a mesma ordem
            List<Equipment_Maintenance_Item__c> originalEMIs = caseToEMIs.get(originalMR.Id);
            
            if(originalEMIs != null){
                for(Equipment_Maintenance_Item__c emi : originalEMIs){
                    Equipment_Maintenance_Item__c emiClone = emi.clone(false, true, false, false);
                    emiClone.Maintenance_Request__c = newMR.Id;
                    lstEquipmentMaintenanceItemClone.add(emiClone);
                }
            }
        }
        
        if(!lstEquipmentMaintenanceItemClone.isEmpty() && Schema.sObjectType.Equipment_Maintenance_Item__c.isCreateable()){
            insert lstEquipmentMaintenanceItemClone;
        }
    }
    
    public static void updateMaintenanceRequest(List<Case> lstMaintenanceRequest) {
        
        List<Case> mrToCreate = new List<Case>();
        
        for(Case mr : lstMaintenanceRequest){
            if(mr.Status == 'Closed' && (mr.Type == 'Repair' || mr.Type == 'Routine Maintenance')){
                
                Case newMR = new Case();
                newMR.Subject = 'New Maintenance Request';
                newMR.Status = 'New';
                newMR.Type = 'Routine Maintenance';
                newMR.Date_Reported__c = System.today();
                newMR.Vehicle__c = mr.Vehicle__c;
                newMR.Date_Due__c = dtDueDate(mr);
                mrToCreate.add(newMR);
                
            }
        }
        
        if(!mrToCreate.isEmpty() && Schema.sObjectType.Case.isCreateable()){
            insert mrToCreate;
            createEquipmentMaintenanceItem(mrToCreate, lstMaintenanceRequest);
        }
    }
}