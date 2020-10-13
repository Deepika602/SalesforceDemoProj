({
	callComp1Method : function(component, event, helper) {
		var appEvnt = $A.get("e.c:ApplicationEventDemo");
        appEvnt.setParams({
            'parentType':'Child 2'
        });
        
        appEvnt.fire();
	}
})