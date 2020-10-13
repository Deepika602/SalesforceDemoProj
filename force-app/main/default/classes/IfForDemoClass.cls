public class IfForDemoClass {
    
   public Map<String,String> branchMap=new Map<String,String>();
   public List<String> lstBranchCode=new List<String>();
   public Set<String> stvalidId=new Set<String>();
    
    public IfForDemoClass()
    {
        
        branchMap.put('001', 'kukatpally');
        branchMap.put('002', 'JNTU');
        branchMap.put('003', 'SanathNagar');
        branchMap.put('004', 'Ameerpet');
        branchMap.put('005', 'KPHB');
        branchMap.put('006', 'Srinagar');
        branchMap.put('007', 'MothiNagar');
        branchMap.put('008', 'MarutiNagar');
        branchMap.put('009', 'Koti');
        branchMap.put('010', 'DilshukNagar');
       
        
        lstBranchCode.add('001');
        lstBranchCode.add('009');
        lstBranchCode.add('012');
        lstBranchCode.add('013');
        lstBranchCode.add('003');
        
        Date type=Date.newInstance(2010, 01, 01);
        Date type1=type.addMonths(08);
        Date type2=type.addDays(06);
        String res=getCategory(type2);
        System.debug(res);
    }
    public String getCategory(Date type)
    {
        Integer calDate=type.daysBetween(Date.today());
        String result;
        if(calDate<10)
        {
            result='Category 1';
        }
        else if(calDate>10 && calDate<20)
        {
            result='Category 2';
        }
        else if(calDate>21 && calDate<50)
        {
             result='Category 3';
        }
         else if(calDate>51 && calDate<1000)
        {
             result='Category 4';
        }
         else if(calDate>1001)
         {
             result='Category 5';
         }
        return result;
    }
    
    public Set<String> getValidBranches(List<String> lst)
    {
        Set<String> st=new Set<String>();
        for(String str:lst)
        {
            if(branchMap.containsKey(str))
            {
                st.add(str);
                System.debug(branchMap.get(str));
            }
        }
        return st;
    }
    
}