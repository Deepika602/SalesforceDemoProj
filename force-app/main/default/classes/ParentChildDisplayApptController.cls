public class ParentChildDisplayApptController {
@AuraEnabled
    public static AppointmentWrapper createAppoitment(string appt,Id patId,Id physId,Id hospId)
    { 
       Appoitment__c app = new Appoitment__c();
        app.Name = appt;
        app.Patient__c = patId;
        app.Physician__c = physId;
        app.Hospital__c = hospId;
        
        insert app;
            
            AppointmentWrapper appWrapper = new AppointmentWrapper();
            appWrapper.patient = patId;
            
            
            return appWrapper;
        }
       
     public class AppointmentWrapper
    {
        @AuraEnabled
        public String patient;
       
    }
    
}