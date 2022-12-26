@IsTest
private class ProjectCalloutServiceTest {
//    @TestSetup
//    public static void setup(){
//
//    }

    @IsTest  //Implement mock callout tests here
    public static void successTest() {
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock());
        Opportunity newOpp = new Opportunity(Name = 'Test Op', CloseDate = System.today(), Amount = 10000, StageName = 'Qualification');
        insert newOpp;
        insert new ServiceTokens__c (Token__c = 'token', Name = 'ProjectServiceToken');
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        Test.startTest();
        ProjectCalloutService.postOpportunityToPMS(new List<Id>{
                newOpp.Id
        });
        Test.stopTest();
        // Verify that the response received contains fake values
        Opportunity updatedOpp = [SELECT StageName FROM Opportunity WHERE Id = :newOpp.Id];

        System.assertEquals('Submitted Project', updatedOpp.StageName);
    }

    @IsTest  //Implement mock callout tests here
    public static void failureTest() {
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure());
        Opportunity newOpp = new Opportunity(Name = 'Test Op', CloseDate = System.today(), Amount = 10000, StageName = 'Qualification');
        insert newOpp;
        insert new ServiceTokens__c (Token__c = 'token', Name = 'ProjectServiceToken');
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        Test.startTest();
        ProjectCalloutService.postOpportunityToPMS(new List<Id>{
                newOpp.Id
        });
        Test.stopTest();
        // Verify that the response received contains fake values
        Opportunity updatedOpp = [SELECT StageName FROM Opportunity WHERE Id = :newOpp.Id];

        System.assertEquals('Resubmit Project', updatedOpp.StageName);
    }
}