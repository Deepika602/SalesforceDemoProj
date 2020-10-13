public class RegistrationHelper {
    
    RegistrationController rC=new RegistrationController();
    public RegistrationHelper()
    {
     String mName=getPatientName();
        System.debug(mName);
    }
    
    public String getPatientName()
    {
        return rC.name;
    }    

}