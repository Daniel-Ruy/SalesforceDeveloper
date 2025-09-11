public with sharing class MaintenanceRequestHelper {

    public static void updateMaintenanceRequest(List<Maintenance_Request__c> lstMaintenanceRequest) {
        List<Case> maintenanceRequest = new List<Case>();
        for(Case mr : lstMaintenanceRequest){
            if(mr.Status == 'Closed' & mr.Type == 'Repair' || mr.Type == 'Routine Maintenance'){
                
            }
            
        }

        
    }

}