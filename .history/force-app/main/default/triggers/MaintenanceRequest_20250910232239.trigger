trigger MaintenanceRequest on SOBJECT (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        MaintenanceRequestTriggerHandler.updateMaintenanceRequest(Trigger.new, Trigger.oldMap);
    }

}