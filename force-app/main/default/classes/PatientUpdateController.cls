public class PatientUpdateController {
    
     public void updateisActive()
    {
        List<Patient__c> ls=[SELECT id,isActive__c from Patient__c];
        for(Patient__c app:ls)
        {
            app.isActive__c=false;
        }
        update ls;
    }


}