({
	loadBoardWithCells : function(component) {
		return $LCH.ServerApexPromise(component, 'getBoard', {
			boardId: component.get('v.recordId')
		});
	},
	
	displayCells : function(component) {
		return function(returnValue) {
			console.log('######### displayCells returnValue2', returnValue);
		}
	}
})