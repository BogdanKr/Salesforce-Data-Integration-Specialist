public class ProjectCalloutServiceMockFailure implements HttpCalloutMock{
   //Implement http mock callout failure here 

   public HttpResponse respond(HttpRequest param1) {
      HttpResponse response = new HttpResponse();
      response.setHeader('Content-Type', 'application/json');
      response.setBody('hello');
      response.setStatusCode(500);
      return response;
   }
}