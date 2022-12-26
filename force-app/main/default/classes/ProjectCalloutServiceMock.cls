public class ProjectCalloutServiceMock implements HttpCalloutMock{
   //Implement http mock callout here

   public HttpResponse respond(HttpRequest param1) {
      HttpResponse response = new HttpResponse();
      response.setHeader('Content-Type', 'application/json');
      response.setBody('hello');
      response.setStatusCode(201);
      return response;
   }
}