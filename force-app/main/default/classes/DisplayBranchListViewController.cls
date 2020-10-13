public class DisplayBranchListViewController 
{
    @AuraEnabled
    public static List<Branch__c> getBranchRecords()
    {
        List<Branch__c> ls=[SELECT id,Name,Hospital__r.Name,BranchCode__c,
                            BranchHead__r.Name FROM Branch__c];
        return ls;
    }
}