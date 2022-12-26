public class BillingCalloutService {
    //Implement business and callout logic methods here
//    public static void callBillingService(List<Project__c> projects) {
//        makeCallOut(projects.get(0).Id);
//    }
    public static void callBillingService(Project__c[] newProjects, Map<Id, Project__c> oldProjectsMap) {
//        List<Project__c> projects = new List<Project__c>();
        for (Project__c p : newProjects) {
            if (oldProjectsMap.get(p.Id).Status__c != p.Status__c && p.Status__c == 'Billable') {
//                projects.add(p);
                makeCallOut(p.Id);
            }
        }
//        if (!projects.isEmpty()) {
//            makeCallOut(projects.get(0).Id);
//        }
    }

    @Future(Callout=true)
    public static void makeCallOut(String id) {
        Project__c pr = [SELECT Id, Billable_Amount__c FROM Project__c WHERE Id = :id];
        BillingServiceProxy.project project = new BillingServiceProxy.project();
        project.username = 'bsUser1';
        project.password = 'bsPass1';
        project.projectid = id;
        project.billAmount = pr.Billable_Amount__c;

        BillingServiceProxy.InvoicesPortSoap11 bill = new BillingServiceProxy.InvoicesPortSoap11();
        String resp = bill.billProject(project);
        System.debug('Response - ' + resp);
        if (bill.billProject(project) == 'OK') {
            pr.Status__c = 'Billed';
            update pr;
        }
    }
}