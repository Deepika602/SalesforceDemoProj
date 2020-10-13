({
	eventExecutedMethod : function(component, event, helper) {
        
        var name = event.getParam("name");
        console.log(name);
		var brnchList = event.getParam("branchList");
        console.log('Parent component');
        console.log(brnchList);
	}
})