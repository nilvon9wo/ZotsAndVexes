({
	doInit : function(component, event, helper) {
		helper.loadGamePlayers(component)
			.then($A.getCallback(helper.displayCells(component)));
	}
})