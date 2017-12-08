({
	doInit : function(component, event, helper) {
		var gamePlayer = component.get('v.gamePlayerByIdMap').get(component.get('v.gamePlayerId'));
		component.set('v.simpleMarker', (gamePlayer.PlayOrder__c === 1) ? 'X' : 'O');
		component.set('v.player', gamePlayer.Player__r);
	}
})