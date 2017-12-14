({
	occupy : function(component, event, helper) {
		helper.occupy(component)
			.then($A.getCallback(helper.updateBoard(component)));
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