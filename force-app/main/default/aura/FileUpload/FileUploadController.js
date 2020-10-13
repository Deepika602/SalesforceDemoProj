({
	finshUpload : function(component, event, helper)
    {
		var files = event.getParam("files");
        var file = file[0];
        console.log(file.name);
        console.log(file.documentId);
    }
})