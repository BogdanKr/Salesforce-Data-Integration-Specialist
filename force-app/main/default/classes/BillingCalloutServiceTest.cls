@IsTest
private class BillingCalloutServiceTest {
    //Implement mock callout tests here
    @IsTest
    static void testCallout() {
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());
        // Call the method that invokes a callout
        Opportunity op = new Opportunity(Name = 'Test Op', CloseDate = System.today(), Amount = 10000, StageName = 'Qualification');
        insert op;
        Project__c project = new Project__c(ProjectRef__c = 'Some Id', Name = 'projectName', Opportunity__c = op.Id,
                Start_Date__c = System.today(), End_Date__c = System.today(), Billable_Amount__c = 10000, Status__c = 'Running');
        insert project;
        Test.startTest();
        BillingCalloutService.makeCallOut(project.Id);
        Test.stopTest();
        System.assertEquals('Billed', [SELECT Status__c FROM Project__c WHERE Id = :project.Id].Status__c);
    }

    @IsTest
    static void testCalloutFailure() {
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMockFailure());
        // Call the method that invokes a callout
        // Call the method that invokes a callout
        Opportunity op = new Opportunity(Name = 'Test Op', CloseDate = System.today(), Amount = 10000, StageName = 'Qualification');
        insert op;
        Project__c project = new Project__c(ProjectRef__c = 'Some Id', Name = 'projectName', Opportunity__c = op.Id,
                Start_Date__c = System.today(), End_Date__c = System.today(), Billable_Amount__c = 10000, Status__c = 'Running');
        insert project;
        Test.startTest();
        BillingCalloutService.makeCallOut(project.Id);
        Test.stopTest();
        System.assertEquals('Running', [SELECT Status__c FROM Project__c WHERE Id = :project.Id].Status__c);
    }
}