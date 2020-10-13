public class DisplayPatPhysHospitalController {
    
    @AuraEnabled
    public static AppointmentWrapper getPatPhyHospInfo()
    {
        
        try{
            
           List<Patient__c> patList =[SELECT Id,Name from Patient__c];
           
            List<Physician__c> phyList=[SELECT Id,Name from Physician__c];
            
             List<Account> hosList=[SELECT Id,Name from Account];
            
            AppointmentWrapper appWrapper = new AppointmentWrapper();
            appWrapper.patient = patList;
            appWrapper.physician=phyList;
            appWrapper.acc=hosList;
            
            return appWrapper;
        }
        catch(Exception ex){
        	throw new AuraException('Custom message');
        }
    }
    
    public class AppointmentWrapper
    {
        @AuraEnabled
        public List<Patient__c> patient;
        @AuraEnabled
        public List<Physician__c> physician;
        @AuraEnabled
        public List<Account> acc;
    }
    
    @AuraEnabled 
   public static Id createAppoitment(string appt,Id patId,Id physId,Id hospId)
   {
        Appoitment__c app = new Appoitment__c();
        app.Name = appt;
        app.Patient__c = patId;
        app.Physician__c = physId;
        app.Hospital__c = hospId;
        
        insert app;
        
        return app.Id;
      } 
   @AuraEnabled
    public static AppointmentWrapper1 createAppoitment1(string appt,Id patId,Id physId,Id hospId)
    { 
       Appoitment__c app = new Appoitment__c();
        app.Name = appt;
        app.Patient__c = patId;
        app.Physician__c = physId;
        app.Hospital__c = hospId;
        
        insert app;
            
            AppointmentWrapper1 appWrapper = new AppointmentWrapper1();
            appWrapper.patient = patId;
            
            
            return appWrapper;
        }
       
     public class AppointmentWrapper1
    {
        @AuraEnabled
        public String patient;
       
    }

}