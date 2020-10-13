public class AccountViewCustomController {

    

public Account acc{get;set;}
    public string accName{get;set;}
    public string selectedState{get;set;}
    
    public integer indexVal = 0;
    
    public AccountViewCustomController(){
        id accId = ApexPages.currentPage().getParameters().get('aid');
        accName = ApexPages.currentPage().getParameters().get('aName');
        acc = [Select id,name,rating,type,BillingStreet,BillingState,BillingCity from Account where id = :accId];
    
    }
    public void stateChange(){
        accName = 'Rainbow 1234 - '+selectedState;
    }
    
    public void actionFunctionMethod(){
        accName = 'Action funcion executed';
    }
    
    public void actionPollerMethod(){
        List<string> lstNames = new List<String>{'Dhoni','Sachin','Kohli','Rohit'};
        
        accName = lstNames[indexVal];
        indexVal=indexVal+1;
    }

}