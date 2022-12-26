trigger ProjectTrigger on Project__c (after update) {
    //Call the Billing Service callout logic here

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
        }
        if (Trigger.isUpdate) {
        }
        if (Trigger.isDelete) {
        }
    }
    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            ProjectTriggerHandler.onAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}