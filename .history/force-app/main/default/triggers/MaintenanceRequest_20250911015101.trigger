trigger MaintenanceRequest on SOBJECT (after update) {

    if(Trigger.isAfter && Trigger.isUpdate){
        MaintenanceRequestHelper.updateWorkOrders(trigger.new());
    }



}