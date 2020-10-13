public class ContactTriggerHandler {
    
    public void onAfterInsert(List<Contact> contactLst)
    {
        set<ID> setofAccountId=new set<ID>();
        for(Contact con:contactLst)
        {
            setofAccountId.add(con.AccountId);
        }
        //Integer count=[Select count(Id) from contact where accountID IN: st];'0013t00001XSnMWAA1'
       // Map<ID,Integer> =new Map<ID,Integer>([SELECT Account.Id,count(Id) from Contact where 
        //  Account.Id IN :st group by Account.Id]);
        Map<Id,Account> mapofAccIdToContacts = new Map<Id,Account>([Select Id,(Select Id From Contacts) From Account Where Id IN : setofAccountId]);
        List<Contact> Con = [Select Id from Contact where Accountid IN : setofAccountId];
        for(Account acc:mapofAccIdToContacts.values())
        {
            acc.Contact_Count__c=con.size()-1;
        }
        update mapofAccIdToContacts.values();
        for(Contact objCon : contactLst){
            if(mapofAccIdToContacts.containskey(objCon.accountID) && mapofAccIdToContacts.get(objCon.accountID).Contact_Count__c>4)
                objCon.addError('cannot have more than 5 contacts per account');
              
        }
    }
    }