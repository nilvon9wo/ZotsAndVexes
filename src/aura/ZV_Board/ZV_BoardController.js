({
	doInit : function(component, event, helper) {
		helper.loadBoardWithCells(component)
			.then($A.getCallback(helper.setBoard(component)));
	},
	
	loadGamePlayers: function(component, event, helper) {
		helper.loadGamePlayers(component)
			.then($A.getCallback(helper.displayCells(component)));
	}
})