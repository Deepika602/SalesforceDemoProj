trigger AccountTrigger on Account (before insert,before update,after insert, after update) {
    AccountTriggerHandler handler = new AccountTriggerHandler();
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            //handler.onBeforeInsert(Trigger.new);
        }
        else if(Trigger.isUpdate){
            //handler.onBeforeUpdate(Trigger.new,Trigger.oldMap);
        }
    }
    else if(Trigger.isAfter){
        if(Trigger.isInsert){
            //handler.onAfterInsert(Trigger.new);
        }
        else if(Trigger.isUpdate){
           //handler.onAfterUpdate(Trigger.new,Trigger.oldMap);
        }
    }
}