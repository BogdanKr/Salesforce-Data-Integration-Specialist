public class ProjectCalloutService {
    //Complete the implementation for business and callout logic
    //using Named Credentials
    @InvocableMethod(Label='Post Opportunity To PMS' Description=' Some description' Category='Opportunity')
    public static void postOpportunityToPMS(List<Id> ids) {
        System.enqueueJob(new QueueablePMSCall(ids.get(0)));
    }

    public class QueueablePMSCall implements Queueable, Database.AllowsCallouts {
        private final Id id;
        public QueueablePMSCall(Id id) {
            this.id = id;
        }
        public void execute(QueueableContext param1) {
            Opportunity op = [SELECT Id, Name, Account.Name, CloseDate, Amount FROM Opportunity WHERE Id = :id];
            String json = '{' +
                    '"opportunityId": "' + op.Id + '", ' +
                    '"opportunityName": "' + op.Name + '", ' +
                    '"accountName": "' + op.Account.Name + '", ' +
                    '"closeDate": "' + op.CloseDate + '", ' +
                    '"amount": ' + op.Amount + '}';
            ServiceTokens__c tokenSetting = [SELECT Token__c FROM ServiceTokens__c WHERE Name = 'ProjectServiceToken'];
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:ProjectService/');
            req.setMethod('POST');
            req.setHeader('content-type', 'application/json');
            req.setHeader('token', tokenSetting.Token__c);
            req.setBody(json);
            Http http = new Http();
            HttpResponse res = http.send(req);
            System.debug('response - ' + res);
            System.debug('response body - ' + res.getBody());
            if (res.getStatusCode() == 201) {
                op.StageName = 'Submitted Project';
                update op;
            } else {
                op.StageName = 'Resubmit Project';
                update op;
            }
        }

    }
}