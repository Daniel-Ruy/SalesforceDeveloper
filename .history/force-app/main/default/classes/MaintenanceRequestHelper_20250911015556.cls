public with sharing class MaintenanceRequestHelper {

    public static List<Equipment_Maintenance_Item__c> equipmentMaintenanceItem(List<Case> lstCase){
        return [SELECT Id, Maintenance_Request__c, Equipment__c 
                FROM Equipment_Maintenance_Item__c 
                WHERE Maintenance_Request__c IN :lstCase];
    }

    public static Map<Id, Integer> calculateDueDates(List<Case> lstMaintenanceRequest){
        List<Equipment_Maintenance_Item__c> allEMIs = equipmentMaintenanceItem(lstMaintenanceRequest);

        Set<Id> allEquipmentIds = new Set<Id>();
        Map<Id, List<Equipment_Maintenance_Item__c>> caseToEMIs = new Map<Id, List<Equipment_Maintenance_Item__c>>();
        for(Equipment_Maintenance_Item__c emi : allEMIs){
            allEquipmentIds.add(emi.Equipment__c);
            if(!caseToEMIs.containsKey(emi.Maintenance_Request__c)){
                caseToEMIs.put(emi.Maintenance_Request__c, new List<Equipment_Maintenance_Item__c>());
            }
            caseToEMIs.get(emi.Maintenance_Request__c).add(emi);
        }

        Map<Id, Product2> equipMap = new Map<Id, Product2>(
            [SELECT Id, Maintenance_Cycle__c FROM Product2 WHERE Id IN :allEquipmentIds]
        );

        Map<Id, Integer> caseDueDates = new Map<Id, Integer>();
        for(Case mr : lstMaintenanceRequest){
            Integer lowerValue;
            List<Equipment_Maintenance_Item__c> emIs = caseToEMIs.get(mr.Id);
            if(emIs != null){
                for(Equipment_Maintenance_Item__c emi : emIs){
                    Product2 prod = equipMap.get(emi.Equipment__c);
                    if(prod != null && (lowerValue == null || prod.Maintenance_Cycle__c < lowerValue)){
                        lowerValue = prod.Maintenance_Cycle__c.intValue();
                    }
                }
            }
            caseDueDates.put(mr.Id, lowerValue != null ? lowerValue : 0);
        }

        return caseDueDates;
    }

    public static void createEquipmentMaintenanceItem(List<Case> newCases, List<Case> originalCases){
        List<Equipment_Maintenance_Item__c> allEMIs = equipmentMaintenanceItem(originalCases);

        Map<Id, List<Equipment_Maintenance_Item__c>> caseToEMIs = new Map<Id, List<Equipment_Maintenance_Item__c>>();
        for(Equipment_Maintenance_Item__c emi : allEMIs){
            if(!caseToEMIs.containsKey(emi.Maintenance_Request__c)){
                caseToEMIs.put(emi.Maintenance_Request__c, new List<Equipment_Maintenance_Item__c>());
            }
            caseToEMIs.get(emi.Maintenance_Request__c).add(emi);
        }

        List<Equipment_Maintenance_Item__c> lstEquipmentMaintenanceItemClone = new List<Equipment_Maintenance_Item__c>();
        for(Integer i = 0; i < newCases.size(); i++){
            Case newMR = newCases[i];
            Case originalMR = originalCases[i];
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

    public static void updateWorkOrders(List<Case> lstMaintenanceRequest){
        List<Case> mrToCreate = new List<Case>();
        Map<Id, Integer> caseDueDates = calculateDueDates(lstMaintenanceRequest);

        for(Case mr : lstMaintenanceRequest){
            if(mr.Status == 'Closed' && (mr.Type == 'Repair' || mr.Type == 'Routine Maintenance')){
                Case newMR = new Case();
                newMR.Subject = 'New Maintenance Request';
                newMR.Status = 'New';
                newMR.Type = 'Routine Maintenance';
                newMR.Date_Reported__c = System.today();
                newMR.Vehicle__c = mr.Vehicle__c;
                newMR.Date_Due__c = System.today().addDays(caseDueDates.get(mr.Id));
                mrToCreate.add(newMR);
            }
        }

        if(!mrToCreate.isEmpty() && Schema.sObjectType.Case.isCreateable()){
            insert mrToCreate;
            createEquipmentMaintenanceItem(mrToCreate, lstMaintenanceRequest);
        }
    }
}
