({
	cancelClicled : function(component, event, helper) {
		component.set("v.isShow1",false);
	},
    SubmitRegistrationClicked : function(component, event, helper) {
        var parmvalues=event.getParam('arguments');
		alert(parmvalues.RegName);
        alert(parmvalues.RegId);
	}
})