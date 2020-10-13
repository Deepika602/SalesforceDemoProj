public class firstVFPageController {
    //changes in org
    public String selectedValue { get; set; }

    public String name { get; set; }
    
     public String outputname { get; set; }
     
     public List<selectOption> stateList { get; set; }
     
    
     
     public List<Contact> ls=new List<Contact>();
     
     public List<selectOption> ratingList{get;set;}
     
      public String selectedRating {get;set;}
     
     public List<selectOption> typeList{get;set;}
     
    public firstVFPageController()
    {
    name='Arjun';
    stateList=new List<selectOption>();
    
   
    selectOption so1=new selectOption('','Selected');
    selectOption so2=new selectOption('Telangana','TS');
    selectOption so3=new selectOption('AndhraPradesh','AP');
    stateList.add(so1);
    stateList.add(so2);
    stateList.add(so3);
    
    ratingList = new List<selectOption>();
        
        schema.SobjectType sobj = schema.getglobaldescribe().get('Account');
        
        Map<string,schema.sobjectField> fieldMap =  sobj.getDescribe().fields.getMap();
        
        Schema.DescribeFieldResult ratingField = fieldMap.get('Rating').getDescribe();
         
         
        List<schema.picklistEntry> ratingPicklistValues = ratingField.getPicklistValues();
        
        
        for(schema.picklistEntry pickVal: ratingPicklistValues ){
            selectOption so = new selectOption(pickVal.getLabel(),pickVal.getValue());
            
            ratinglist.add(so);
        }
        
        typeList = new List<selectOption>();
        

        
        Schema.DescribeFieldResult typeField = Account.Type.getDescribe();
           
        List<schema.picklistEntry> typePicklistValues = typeField.getPicklistValues();
        
        
        for(schema.picklistEntry pickVal: typePicklistValues ){
            selectOption so = new selectOption(pickVal.getLabel(),pickVal.getValue());
            
            typeList.add(so);
        }
    
    }
    
    public List<SelectOption> contactlist
    {
        get
        {
            ls = [Select firstname,lastname from contact];
            
            contactlist = new List<SelectOption>();
             selectoption n = new selectoption('none','-None-');
        contactlist.add(n);
            
            for(contact con : ls)
            {
              if(con.firstname!=null && con.lastname!=null){
                contactlist.add(new SelectOption(con.firstname, con.lastname));
                }
            }
            return contactlist;
        }
        set;
    }
    
     public void submitClicked() {
    
       // outputname=name;
       outputname=selectedValue;
    }
    
     public void doInit() {
       name='Deepika';
    }
    
    



}