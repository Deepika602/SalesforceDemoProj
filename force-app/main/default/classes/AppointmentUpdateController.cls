public class AppointmentUpdateController {
    
    public void updateStatus()
    {
        List<Appoitment__c> ls=[SELECT id,status__c from Appoitment__c];
        for(Appoitment__c app:ls)
        {
            app.status__c='Open';
        }
        update ls;
    }
   
}