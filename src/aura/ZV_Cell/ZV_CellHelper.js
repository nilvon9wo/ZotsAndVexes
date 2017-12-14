({
	occupy : function(component) {
		return $LCH.ServerApexPromise(component, 'occupyCell', {
			cellId: component.get('v.cell.Id')
		});
	},
	
	updateBoard: function(component) {
		var self = this;
		return $A.getCallback(function(cellOccupyResult) {
			self.updateCells(cellOccupyResult.updatedCellList);
			self.stopGame(component, cellOccupyResult.gameStatus);
		});
	},
	
	updateCells: function(updatedCellList) {
		var self = this;
		if (updatedCellList) {
			updatedCellList.forEach(function(updatedCell, index) {
				var updateCell = self.updateCell(updatedCell);
				var milliseconds = index === 0 ? 0 : 1000; 
				$LCH.WaitPromise(milliseconds)
					.then($A.getCallback(updateCell));
			});
		}
	},

	updateCell: function(updatedCell) {
		return $A.getCallback(function() {
			var appEvent = $A.get('e.c:ZV_CellUpdateEvent');
			appEvent.setParam('updatedCell', updatedCell);
			appEvent.fire();
		});
	},

	stopGame: function(component, gameStatus) {
		if (gameStatus === 'In Progress') {
			// TODO
		}
	}
})