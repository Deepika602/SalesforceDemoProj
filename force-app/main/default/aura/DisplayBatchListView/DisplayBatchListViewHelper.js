({
	doInitHelper : function(component, event,helper) {
		var aMethod = component.get("c.getBranchRecords");
        /*aMethod.setParams({
            'param1':'value',
            'param2':'value'
        });*/
        
        aMethod.setCallback(this,function(retVal){
            alert('enter');
            var currentState = retVal.getState(); //SUCCESS or ERROR
            alert('hi');
            if(currentState == 'SUCCESS'){
                alert('success');
                var branchList = retVal.getReturnValue();
                component.set("v.branchList",branchList);
                console.log(component.get("v.branchList"));
            }
            else{
                alert('Error');
            }
        });

		$A.enqueueAction(aMethod);  
	}
})