trigger BranchTrigger on Branch__c (before insert,before update,after insert,after update,after delete) {


 BranchTriggerHandler handler = new BranchTriggerHandler();
    
    If(Trigger.isBefore){
        if(Trigger.isInsert){
            handler.onBeforeInsert(Trigger.New);
        }
        else if(Trigger.isUpdate){
            handler.onBeforeUpdate(Trigger.New,Trigger.OldMap);
        }
        else if(Trigger.isDelete){
        
        }
    }
    else if(Trigger.isAfter){
        if(Trigger.isInsert){
            handler.onAfterInsert(Trigger.New);
        }
        else if(Trigger.isUpdate){
             handler.onAfterUpdate(Trigger.New,Trigger.OldMap);
        }
        else if(Trigger.isDelete){
        
        }
    }
}