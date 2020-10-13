({
	createRegClicled : function(component, event, helper) 
    {
		component.set("v.isShow",true);	 
	},
    callSubmitRegMethod : function(component, event, helper) 
    {
		var childRef=component.find("regCreateComp");
        childRef.SubmitRegistration('Deep','23232');
	}
})