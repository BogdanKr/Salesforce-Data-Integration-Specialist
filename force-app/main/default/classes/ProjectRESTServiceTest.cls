@IsTest
private class ProjectRESTServiceTest {
    //Implement Apex REST service tests here
    @IsTest
    static void testCreateProject() {
        // Call the method to test
        Opportunity op = new Opportunity(Name = 'Test Op', CloseDate = System.today(), Amount = 10000, StageName = 'Qualification');
        insert op;
        String response = ProjectRESTService.postProjectData('Some Id', 'Ferocious chipmunk', op.Id, System.today(),
                System.today(), 10000, 'Billed');
        // Verify results
        System.assertEquals('OK', response);
    }

    @IsTest
    static void testCreateProjectFailure() {
        // Call the method to test
        Opportunity op = new Opportunity(Name = 'Test Op', CloseDate = System.today(), Amount = 10000, StageName = 'Qualification');
        insert op;
        String response = ProjectRESTService.postProjectData(null, 'Ferocious chipmunk', op.Id, System.today(),
                System.today(), 10000, 'Billed');
        // Verify results
        String expResp = 'Upsert failed. First exception on row 0; first error: MISSING_ARGUMENT, ProjectRef__c not specified: []';
        System.assertEquals(expResp, response);
    }
}