public class RegistrationPatientController {
    public String email;
    public RegistrationPatientController(String email)
    {
        
        validatePatient(email);
        System.assertEquals(true,validatePatient(email));
        
    }
     public Boolean validatePatient(String email)
    {
        List<Patient__c> pat=[SELECT Id,Name,Email__c,Age__c From Patient__c];
        Boolean Flag;
        for(Patient__c p:pat)
        {
            if(p.Email__c.equals(email))
            {
                Flag=true;
            }
            else
            {
                Flag=false;
            }
        }
        return Flag;
    }

}