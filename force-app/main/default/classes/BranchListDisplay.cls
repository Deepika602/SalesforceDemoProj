public class BranchListDisplay {
     @AuraEnabled
    public static List<Branch__c> getBranchRecords()
    {
        List<Branch__c> ls=[SELECT id,Name,Hospital__r.Name,BranchCode__c,
                            BranchHead__r.Name FROM Branch__c];
        return ls;
    }
    @AuraEnabled
    public static HospitalWrapper getHospitalInfo(string hospId){
        try{
            Account hosp = [Select id,name from Account where id = :hospId];
            
            
            List<Branch__c> brList = [Select id,Name,Hospital__r.Name,BranchCode__c,
                                                                            BranchHead__r.Name from  Branch__c 
                                                                            Where hospital__c = :hospId];
            
            HospitalWrapper hospWrapper = new HospitalWrapper();
            hospWrapper.hospital = hosp;
            hospWrapper.branchList = brList;
            
            return hospWrapper;
        }
        catch(Exception ex){
        	throw new AuraException('Custom message');
        }
    }
    
    public class HospitalWrapper{
        @AuraEnabled
        public Account hospital;
        @AuraEnabled
        public List<Branch__c> branchList;
    } 

}