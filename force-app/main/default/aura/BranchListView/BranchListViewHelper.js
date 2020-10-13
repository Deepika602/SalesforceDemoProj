({
    doInitHelper : function(component,event,helper) {
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
                console.log(branchList);
                component.set("v.branchLst",branchList);
                console.log(component.get("v.branchLst"));
            }
            else{
                alert('Error');
            }
        });

		$A.enqueueAction(aMethod);  
	},
     accesButtonClickedHelper : function(component, event, helper) {
		var aMethod = component.get("c.getHospitalInfo");
        alert(component.get("v.recordId"));
        aMethod.setParams({
            'hospId':component.get("v.recordId")
        });
        
        aMethod.setCallback(this,function(retVal){
            var currentState = retVal.getState(); //SUCCESS or ERROR
            if(currentState == 'SUCCESS'){
                var result = retVal.getReturnValue();
                var hosp = result.hospital;
                var branchList = result.branchList;
                component.set("v.branchList1",branchList);
                console.log(component.get("v.branchList1"));
            }
            else{
                alert('Error');
                console.log(error);
            }
        });

		$A.enqueueAction(aMethod);  
	}
})