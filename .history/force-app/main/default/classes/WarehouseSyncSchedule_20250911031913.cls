global with sharing class WarehouseSyncSchedule implements Schedulable{
    
    global void execute(SchedulableContext  sc){
        ID jobId = System.enqueueJob(new WarehouseCalloutService());
    }
    
}