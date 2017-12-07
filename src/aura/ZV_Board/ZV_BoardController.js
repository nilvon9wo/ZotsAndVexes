({
	doInit : function(component, event, helper) {
		helper.loadBoardWithCells(component)	
			.then($A.getCallback(helper.displayCells(component)));
	}
})