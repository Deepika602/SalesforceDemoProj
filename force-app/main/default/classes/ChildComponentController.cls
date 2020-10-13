public class ChildComponentController {
    @AuraEnabled
    public static List<Branch__c> getBranchData()
    {
        List<Branch__c> branchList =[SELECT id,Name from Branch__c];
        
        return branchList;
    }

}