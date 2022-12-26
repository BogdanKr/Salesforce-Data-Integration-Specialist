@RestResource(UrlMapping='/project')
global class ProjectRESTService {
    //Implement service logic here
    @HttpPost
    global static String postProjectData(String projectRef, String projectName, String opportunityId, Date startDate,
            Date endDate, Double amount, String status) {
        Project__c project = new Project__c(ProjectRef__c = projectRef, Name = projectName, Opportunity__c = opportunityId,
                Start_Date__c = startDate, End_Date__c = endDate, Billable_Amount__c = amount, Status__c = status);
        Savepoint sp = Database.setSavepoint();
        try {
            upsert project ProjectRef__c;
            update new Opportunity(Id = opportunityId, DeliveryInstallationStatus__c = 'In progress');
            return 'OK';
        } catch (Exception ex){
            Database.rollback(sp);
            return ex.getMessage();
        }
    }
}