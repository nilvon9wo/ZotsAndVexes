({
	loadBoardWithCells : function(component) {
		return $LCH.ServerApexPromise(component, 'getBoard', {
			boardId: component.get('v.recordId')
		});
	},

	setBoard: function(component) {
		return $A.getCallback(function(board) {
			component.set('v.board', board);
		});
	},

	loadGamePlayers : function(component) {
		return $LCH.ServerApexPromise(component, 'getPlayers', {
			gameId: component.get('v.board.Game__c')
		});
	},
	
	displayCells : function(component) {
		var self = this;
		return $A.getCallback(function(gamePlayers) {
			var board = component.get('v.board');
			
			$ZV.PlayerMarkerHelper.resolvePlayerIcons(gamePlayers);
			var gamePlayerByIdMap = self.buildGamePlayerByIdMap(gamePlayers);
			
			self.createCellContainer(component, board, gamePlayerByIdMap);
		});
	},
	
	buildGamePlayerByIdMap : function(gamePlayers) {
		var gamePlayerByIdMap = new Map();
		gamePlayers.forEach(function(gamePlayer){
			gamePlayerByIdMap.set(gamePlayer.Id, gamePlayer);
		});
		return gamePlayerByIdMap;
	},
	
	createCellContainer: function(component, board, gamePlayerByIdMap) {
		var params = {
			gameId: board.Game__c,
			gamePlayerByIdMap: gamePlayerByIdMap,
			cellRowList: this.buildCellMatrix(board)
		};
		$A.createComponent('c:ZV_CellContainer', params, function(innerComponent){
			component.find('cell-container')
				.set('v.body', innerComponent);
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