({
	getBranchesBtnClicked : function(component, event, helper) {
		var action = component.get("c.getBranchData");
        action.setCallback(this,function(response){
            var compEvnt = component.getEvent("compEvntDemo");
            compEvnt.setParams({
                'name': 'ABCD',
                'branchList':response.getReturnValue(),
                'parentType':'Parent'
            });
            compEvnt.fire();
        });
        
        $A.enqueueAction(action);
	},
     appEventDemoHandler: function(component, event, helper) {
     	console.log(event.getParam('parentType'));   
    }
})