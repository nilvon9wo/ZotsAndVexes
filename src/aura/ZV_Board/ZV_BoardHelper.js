({
	loadBoardWithCells : function(component) {
		return $LCH.ServerApexPromise(component, 'getBoard', {
			boardId: component.get('v.recordId')
		});
	},
	
	displayCells : function(component) {
		return function(board) {
			component.set('v.board', board)
			
			var cellRowList = [];
			for (var index in board.Cells__r) {
				var cell = board.Cells__r[index];
				var row = cell.Y__c - 1;
				if (!cellRowList[row]) {
					cellRowList[row] = [];
				}
				cellRowList[row].push(cell);
			}
			component.set('v.cellRowList', board);
		}
	}
})