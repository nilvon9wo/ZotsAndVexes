({
	loadBoardWithCells : function(component) {
		return $LCH.ServerApexPromise(component, 'getBoard', {
			boardId: component.get('v.recordId')
		});
	},
	
	displayCells : function(component) {
		var self = this;
		return $A.getCallback(function(board) {
			var params = {
				cellRowList: self.buildCellMatrix(board)
			}
			$A.createComponent('c:ZV_CellContainer', params, function(innerComponent){
				component.find('cell-container')
					.set('v.body', innerComponent);
				console.log('##### innerComponent', innerComponent);
			})
		});
	},
	
	buildCellMatrix: function(board) {
		var cellRowList =  [];
		board.Cells__r.forEach(function(cell){
			var row = cell.Y__c - 1;
			if (!cellRowList[row]) {
				cellRowList[row] = [];
			}
			cellRowList[row].push(cell);
		});
		return cellRowList;
	}
})