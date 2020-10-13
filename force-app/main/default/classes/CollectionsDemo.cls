public class CollectionsDemo {
    public List<String> lstBranchName;
    public Set<String> stDiseaseName;
    public Map<String,String> mpBranchcode;
    public CollectionsDemo()
    {
       lstBranchName=new List<String>();  
       mpBranchcode=new Map<String,String>();
       stDiseaseName=new Set<String>();
        
      lstBranchName=getListOfBranches();
      mpBranchcode=getMapBrancheCodes();
      stDiseaseName=getSetOfDieases();
        
       
    }
    
    public void cloneDemo()
    {
       /* List<String> ls=new List<String>();
        List<String> ls1=new List<String>{'a','b','c'};
        ls=ls1.clone();
        ls1.add('d');*/
        List<Account> ls=new List<Account>();
        Account a=new Account(Name='IcIcI',billingCity='Mumbai');
        ls.add(a);
        
List<Account> ls1=ls.deepClone(); 
        ls1.get(0).Name='BOF';
            
        System.debug(ls);
        System.debug(ls1);
    }
    
    public List<String> getListOfBranches()
    {
        List<String> lstBranchName1=new List<String>();
        lstBranchName1.add('Pediatric');
        lstBranchName1.add('Gynacologist');
        lstBranchName1.add('Orthopedic');
        lstBranchName1.add('cardiologist');
        return lstBranchName1;
        
    }
    public Set<String> getSetOfDieases()
    {
        Set<String> stBranchName1=new Set<String>();
        stBranchName1.add('bonefracture');
        stBranchName1.add('HeartProblem');
        stBranchName1.add('kidsFever');
        stBranchName1.add('womensProblem');
        return stBranchName1;
        
    }
    
    
    public Map<String,String> getMapBrancheCodes()
    {
        Map<String,String> mpBranchCode1=new Map<String,string>();
        mpBranchCode1.put('001','Pediatric');
        mpBranchCode1.put('002','Gynacologist');
        mpBranchCode1.put('003','Orthopedic');
        mpBranchCode1.put('004','cardiologist');
        return mpBranchCode1;
    }
    
    public List<String> addListValue(String BranchName)
    {
       List<String> lstBranchName=new List<String>();
        lstBranchName.add(BranchName);
        return lstBranchName; 
    }
    
    public List<String> deleteListValue(List<String> ls,String BranchName)
    {
        List<String> lstBranchName1=new List<String>(ls);
        Integer result=lstBranchName1.indexOf(BranchName);
        System.debug('Index '+result);
        lstBranchName1.remove(result);
        return lstBranchName1;
    }
    
     public Set<String> addSetValue(String DieaseName)
    {
       Set<String> stDieaseName=new Set<String>();
        stDieaseName.add(DieaseName);
        return stDieaseName; 
    }
    
    public Set<String> deleteSetValue( Set<String> st,String DieaseName)
    {
        Set<String> stDieaseName1=new Set<String>(st);
       // Integer result=stBranchName1.indexOf(DieaseName);
        stDieaseName1.remove(DieaseName);
        return stDieaseName1;
    }
    
     public Map<String,String> addMapValue(String BranchCode,String BranchName)
    {
       Map<String,String> mpBranchName=new Map<String,String>();
        mpBranchName.put(BranchCode,BranchName);
        return mpBranchName; 
    }
    
    public String deleteMapValue(Map<String,String> mp,String BranchCode)
    {
        Map<String,String> mpBranchName1=new Map<String,String>(mp);
       // Integer result=stBranchName1.indexOf(BranchName);
        String BranchName=mpBranchName1.get(BranchCode);
        return BranchName;
    }
    

}