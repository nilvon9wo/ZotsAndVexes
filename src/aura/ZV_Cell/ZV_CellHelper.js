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
			self.stopGame(component, cellOccupyResult);
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

	stopGame: function(component, cellOccupyResult) {
		var gameStatus = cellOccupyResult.gameStatus;
		if (gameStatus != 'In Progress') {
			var appEvent = $A.get('e.c:ZV_CellOccupyResultEvent');
			appEvent.setParam('cellOccupyResult', cellOccupyResult);
			appEvent.fire();
		}
		if (gameStatus === 'Won') {
			this.showToast({
		        type: 'success',
		        title: 'Won!',
		        message: cellOccupyResult.winnerNickName + ' has won the game!'
		    })
		}
		if (gameStatus === 'Stalemate') {
			this.showToast({
		        title: 'Stalemate',
		        type: 'info',
		        message: 'The game has ended in a stalemate.'
		    });
		}
	},
	
	showToast: function(params) {
		var toastEvent = $A.get('e.force:showToast');
	    toastEvent.setParams(params);
	    toastEvent.fire();
	}
})