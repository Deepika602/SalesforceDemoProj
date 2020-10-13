public class BranchTriggerHandler
{
    
    public void onBeforeInsert(List<Branch__c> branchLst)
    {
        
        for(Branch__c brnch:branchLst)
        {
            
            brnch.BranchCode__c='2342344';
        }
        
    }
    
    
    public void onBeforeUpdate(List<Branch__c> branchLst,Map<Id,Branch__c> oldMap)
    {
        for(Branch__c branch:branchLst)
        {
            if(branch.BranchCode__c!=oldMap.get(branch.Id).BranchCode__c)
            {
                branch.addError('cannot change');
            }
        }
        
    }
    
    /*public void onAfterInsert(List<Branch__c> brnchLst)
{
List<Branch__share> shareLst=new List<Branch__share>();

for(Branch__c br:brnchLst)
{
Branch__share share=new Branch__share();
share.parentId=br.Id;
share.userOrGroupId=br.BranchHead__c;
share.accessLevel='Edit';
share.RowCause=schema.Branch__share.RowCause.ApexReason__c;
shareLst.add(share);
}
insert shareLst;

set<Id> branchHeadId=new set<Id>();

for(Branch__c br:brnchLst)
{
branchHeadId.add(br.BranchHead__c);
branchHeadId.add(br.OwnerId);

}        
Map<Id,user> mp=new Map<Id,User>([SELECT Id,name,email from user where id in :branchHeadId]);

List<Messaging.SingleEmailMessage> emailList1=new List<Messaging.SingleEmailMessage>();
for(Branch__c br:brnchLst)
{
if(mp.containsKey(br.BranchHead__c))
{
Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
email.setSubject('branch is created'+br.Name);
user head=mp.get(br.BranchHead__c);
String body='Hi '+head.Name +',<br/><br/>This email to notify that new email has been added.<br/>'+
+'<b>Branch Name</b>:'+br.Name+'<br/><br/>Regards,<br/>Support Team';
email.setHtmlBody(body);
email.setToAddresses(new List<String>{head.Email});
if(mp.containsKey(br.OwnerId))
{
email.setCcAddresses(new List<String>{mp.get(br.ownerId).email});
}
emailList1.add(email);

}

}
Messaging.sendEmail(emailList1);


orgwideemailaddress org= [select id,displayname,address from orgwideemailaddress limit 1];
Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
email.setSubject('Test Apex mail');
String body='Hi Ram,<br/><br/>sending this test email from Apex.<br/><br/>Regards,<br/>Support Team';
email.setHtmlBody(body);
email.settoaddresses(new List<String>{'deepika.polasani@gmail.com','karthikmothe13@gmail.com'});
email.setOrgWideEmailAddressId(org.Id);
List<Messaging.SingleEmailMessage> emailList=new List<Messaging.SingleEmailMessage>();
emailList.add(email);
Messaging.sendEmail(emailList);
}*/
    
    public void onAfterInsert(List<Branch__c> brnchLst)
    {
        // sendEmailTemplate(brnchLst);
        sendEmailTemplateWithOutWhatId(brnchLst);
    }
    
    public void sendEmailTemplate(List<Branch__c> brnchLst)
    {
        
        // Map<Id,user> mp=new Map<Id,User>([SELECT Id,name,email from user where id in :branchHeadId]);
        
        orgwideemailaddress org= [select id,displayname,address from orgwideemailaddress limit 1];
        
        EmailTemplate et=[SELECT Id From EmailTemplate where developername='Branch_Notification_Email' limit 1];
        List<Messaging.SingleEmailMessage> emailList1=new List<Messaging.SingleEmailMessage>();
        for(Branch__c br:brnchLst)
        {
            Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
            email.setOrgWideEmailAddressId(org.Id);
            email.setTemplateId(et.Id);    
            email.setTargetObjectId(br.Contact__c);
            email.setWhatId(br.Id);
            email.setSaveAsActivity(true);
            emailList1.add(email);
        }
        
        Messaging.sendEmail(emailList1);
        
    }
    
    public void massEmailMessageDemo(List<Branch__c> brnchLst)
    {
        
        // Map<Id,user> mp=new Map<Id,User>([SELECT Id,name,email from user where id in :branchHeadId]);
        
        EmailTemplate et=[SELECT Id From EmailTemplate where developername='Branch_Notification_Email' limit 1];
        
        List<Id> conIds=new List<Id>();
        List<Id> branchIds=new List<Id>();
        for(Branch__c br:brnchLst)
        {
            conIds.add(br.Contact__c);
            branchIds.add(br.Id);
        }
        
        Messaging.MassEmailMessage email=new Messaging.MassEmailMessage();
        // email.setOrgWideEmailAddressId(org.Id);
        email.setTemplateId(et.Id);    
        email.setTargetObjectIds(conIds);
        email.setWhatIds(branchIds);
        email.setSaveAsActivity(true);
        
        Messaging.sendEmail(new List< Messaging.MassEmailMessage>{email});
        
    }
    
    public void sendEmailTemplateWithOutWhatId(List<Branch__c> brnchLst)
    {
        orgwideemailaddress org= [select id,displayname,address from orgwideemailaddress limit 1];
        set<Id> branchHeadId=new set<Id>();
        
        for(Branch__c br:brnchLst)
        {
            branchHeadId.add(br.BranchHead__c);
            branchHeadId.add(br.OwnerId);
            
        }        
        Map<Id,user> mp=new Map<Id,User>([SELECT Id,name,email from user where id in :branchHeadId]);
        
        EmailTemplate et=[SELECT Id,subject,htmlValue,body From EmailTemplate where developername='Branch_Notification_Email' limit 1];
        List<Messaging.SingleEmailMessage> emailList1=new List<Messaging.SingleEmailMessage>();
        for(Branch__c br:brnchLst)
        {
            Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
            email.setOrgWideEmailAddressId(org.Id);
            String subject=et.Subject;
            String body=et.HtmlValue;
            subject.replace('{!Branch__c.BranchHead__c}',mp.get(br.BranchHead__c).Name);
            body.replace('{!Branch__c.Name}',br.Name);
            body.replace('{!Branch__c.BranchCode__c}',br.BranchCode__c);
            
            email.setSubject(et.Subject);
            email.setHtmlBody(et.HtmlValue);
            email.settoaddresses(new List<String>{mp.get(br.BranchHead__c).Email});
            emailList1.add(email);
        }
        
        Messaging.sendEmail(emailList1);
        
    }
    
    
    public void onAfterUpdate(List<Branch__c> branchLst,Map<Id,Branch__c> oldMap)
    {
        insertShareRecords(oldMap.keySet());
       /* List<Branch__share> shareLst=new List<Branch__share>();
        Set<id> userIdList = new Set<id>();
        set<id> parentIdSet = new Set<id>();
        List<Branch__share> removeBranchShare = new List<Branch__share>();
        
        for(Branch__c br:branchLst)
        {
            if(br.BranchHead__c!=oldMap.get(br.Id).BranchHead__c)
            {  
                Branch__share share=new Branch__share();
                share.parentId=br.Id;
                share.userOrGroupId=br.BranchHead__c;
                share.accessLevel='Edit';
                share.RowCause=schema.Branch__share.RowCause.ApexReason__c;
                shareLst.add(share);
                userIdList.add(oldMap.get(br.Id).BranchHead__c);
                parentIdSet.add(br.Id);
                System.debug(userIdList);
                System.debug(parentIdSet);
            }
            insert shareLst;
            
            System.debug('insert '+shareLst);
        } 
        
        
        
        List<Branch__share> brnchShare= [select id,ParentId from Branch__share where ParentId IN :parentIdSet
                                         And UserOrGroupId IN :userIdList And RowCause='ApexReason__c'];
        
        
        System.debug(brnchShare);
        
        
        delete brnchShare;*/
    }
    
    @Future
    public static void insertShareRecords(Set<Id> st)
    {
        List<Branch__c> branchLst=[SELECT id,name,BranchHead__c from Branch__c where id IN :st];
           List<Branch__share> shareLst = new List<Branch__share>();
         for(Branch__c br:branchLst)
        {
                Branch__share share=new Branch__share();
                share.parentId=br.Id;
                share.userOrGroupId=br.BranchHead__c;
                share.accessLevel='Edit';
                share.RowCause=schema.Branch__share.RowCause.ApexReason__c;
                shareLst.add(share);
             
            }
            insert shareLst;
            
        
    }
    
    
    
}