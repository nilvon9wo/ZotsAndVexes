({
	occupy : function(component, event, helper) {
		helper.occupy(component)
			.then($A.getCallback(helper.updateBoard(component)));
	},
	
	handleCellOccupyResultEvent : function(component, event) {
		var gameStatus = event.getParam('ZV_CellOccupyResult.gameStatus');
		component.set('v.isGameInProgress', gameStatus === 'In Progress');
	},
	
	handleCellUpdateEvent : function(component, event, helper) {
		var thisCell = component.get('v.cell');
		var updatedCell = event.getParam('updatedCell');
		
		if (
				thisCell.X__c === updatedCell.X__c
				&& thisCell.Y__c === updatedCell.Y__c
			) {
				component.set('v.cell', updatedCell);
			}
	}
})