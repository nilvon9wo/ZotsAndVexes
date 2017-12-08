({
	loadGamePlayers : function(component) {
		return $LCH.ServerApexPromise(component, 'getPlayers', {
			gameId: component.get('v.gameId')
		});
	},
	
	displayCells : function(component) {
		var self = this;
		return $A.getCallback(function(gamePlayers) {
			console.log('########## gamePlayers: ', gamePlayers);

			// TODO
		});
	}
})