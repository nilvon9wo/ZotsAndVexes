({
	doInit : function(component, event, helper) {
		helper.loadBoardWithCells(component)	
			.then(helper.displayCells(component));
	}
})