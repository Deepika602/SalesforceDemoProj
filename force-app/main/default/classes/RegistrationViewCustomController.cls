public class RegistrationViewCustomController {

    public boolean isNewButton { get; set; }

  public boolean isEdit { get; set;}
   public boolean isView { get; set;}
   public boolean isNew { get; set;}
 
    public String selectedHospital { get; set; }

    public String selectedBranch { get; set; }
    public String selectedPhysician { get; set; }
    
    public List<selectOption> physicianList { get; set; }

    public List<selectOption> branchList { get; set; }

    public List<selectOption> hospitallist { get; set; }
    
     public List<Account> ls=new List<Account>();
     
     public List<Branch__c> branchLst=new List<Branch__c>();
     public List<Physician__c> physicianLst=new List<Physician__c>();
     
     public Registration__c regis {get; set;}
     
     public RegistrationViewCustomController()
     {
      isNewButton=true;
       isNew=true;
       isEdit=false;
     isView=false;
     regis=new Registration__c();
     ls=[SELECT id,name,(select Hospital__c,Id,name from branches__r),
         (select Hospital__c,Id,name from physicians__r) from Account];
     hospitallist = new List<SelectOption>();
             selectoption n = new selectoption('none','-None-');
        hospitallist.add(n);
            
            for(Account acc : ls)
            {
                hospitallist.add(new SelectOption(acc.id, acc.name));
                 
                 List<Branch__c> brls= acc.branches__r;
                 if(acc.branches__r!=null)
                 {
                 for(Branch__c br:brls)
                 {
                 
                 branchLst.add(br);
                
                 
                 }
                 } 
                 List<Physician__c> phyls= acc.Physicians__r;
                 if(acc.Physicians__r!=null)
                 {
                 for(Physician__c phy:phyls)
                 {
                 
                 physicianLst.add(phy);
                 
                 
                 }
                 }  
            }
      
     }
     
     public void hospitalChange() 
     {
     branchList = new List<SelectOption>();
     for(Branch__c brhos:branchLst)
     {
     if(brhos.Hospital__c==selectedHospital)
     {
        branchList.add(new SelectOption(brhos.Id, brhos.Name)); 
         
      }  
     }
     physicianList=new List<SelectOption>();
     for(Physician__c phyhos:physicianLst)
     {
      if(phyhos.Hospital__c==selectedHospital)
     {
        physicianList.add(new SelectOption(phyhos.Id, phyhos.Name));
           
     }
     }
    }
    
    public PageReference newClicked() {
    isView=true;
    isNew=false;
    regis.Hospital__c=selectedHospital;
    regis.Branch__c=selectedBranch;
    regis.Physician__c=selectedPhysician;
    
    insert regis;
        return null;
        
    }
    
     public void editClicked()
    {
    isView=false;
    isEdit=true;
    isNew=true;
    isNewButton=false;
    
    }
    public void deleteClicked()
    {
    delete regis;
    }
    public void cancelClicked()
    {
    isView=true;
    isEdit=false;
    isNew=false;
    }
    
    public void saveClicked()
    {
    regis.Hospital__c=selectedHospital;
    regis.Branch__c=selectedBranch;
    regis.Physician__c=selectedPhysician;
    
    update regis;
    }
}