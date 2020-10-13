public class RegistrationPatientViewCustomController {

 public List<wrapRegistration> wrapRegistrationList {get; set;}
 
    public List<Registration__c> ls=new List<Registration__c>();
    
    public List<Registration__c> selectedRegistrations {get; set;}
    
    public List<Patient__c> patLst {get; set;}
 
    public RegistrationPatientViewCustomController()
    {
          wrapRegistrationList = new List<wrapRegistration>();
           
          ls=[SELECT id,name,(select Registration__c,Id,name from Patients__r) from Registration__c];
          for(Registration__c reg:ls)
          {
          List<Patient__c> lspat=reg.Patients__r;
          if(lspat.size()==0)
          {
          system.debug('@@@@@@@@@@@@@@@@@@@');
          wrapRegistration wrap=new wrapRegistration(reg);
          
          wrapRegistrationList.add(wrap);
         
          }
           system.debug('@#@#@#@#@#@#'+wrapRegistrationList);
          }  
    }
 
   public void processSelected()
    {
    selectedRegistrations = new List<Registration__c>();
    patLst=new List<Patient__c>();
 
        for(wrapRegistration wrapRegistrationObj : wrapRegistrationList)
         {
            if(wrapRegistrationObj.selected == true) 
            {
                selectedRegistrations.add(wrapRegistrationObj.regis);
            }
         }
         Integer i=1;
         for(Registration__c re:selectedRegistrations)
         {
         
          Patient__c pat=new Patient__c();
          pat.Name='D'+i;
          pat.Age__c=3+i;
          pat.Registration__c=re.id;
          patLst.add(pat);
          i++;
         }
         insert patLst;
     }
 
    // This is our wrapper/container class. In this example a wrapper class contains both the standard salesforce object Account and a Boolean value
    public class wrapRegistration {
        public Registration__c regis {get; set;}
        public Boolean selected {get; set;}
        
          public wrapRegistration(Registration__c rg) {
            regis = rg;
            selected = false;
        }
 
       
    }


}