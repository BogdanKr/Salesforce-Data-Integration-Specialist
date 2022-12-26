/**
 * Created by Bogdan_Krasun on 26.12.2022.
 */

public with sharing class ProjectTriggerHandler {
    public static void onBeforeInsert(Project__c[] newProjects) {
    }
    public static void onBeforeUpdate(Project__c[] newProjects, Map<Id, Project__c> oldProjectsMap) {
    }
    public static void onBeforeDelete(Project__c[] oldProjects) {
    }
    public static void onAfterUpdate(Project__c[] newProjects, Map<Id, Project__c> oldProjectsMap) {
        BillingCalloutService.callBillingService(getBillableProjects(newProjects, oldProjectsMap));
    }

    private static List<Project__c> getBillableProjects(Project__c[] newProjects, Map<Id, Project__c> oldProjectsMap) {
        List<Project__c> projects = new List<Project__c>();
        for (Project__c p : newProjects) {
            if (oldProjectsMap.get(p.Id).Status__c != p.Status__c && p.Status__c == 'Billable') {
                projects.add(p);
            }
        }
        return projects;
    }
}