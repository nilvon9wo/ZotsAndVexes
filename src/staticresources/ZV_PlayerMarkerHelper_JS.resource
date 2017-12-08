// See: http://bobbuzzard.blogspot.hu/2016/12/javascript-promises-in-lightning_30.html
var $ZV = $ZV || {};

$ZV.PlayerMarkerHelper = (function(){
	var DEFAULT_X_MARKER = new SldsIcon('utility:expand', 'error'); 
	var DEFAULT_O_MARKER = new SldsIcon('utility:power', 'warning'); 
	var DEFAULT_BACKUP_MARKER = new SldsIcon('utility:frozen', 'inverse'); 

	function SldsIcon(name, variant) {
		this.name = name;
		this.variant = variant;
	};
	
	SldsIcon.prototype.equals = function(that) {
		return that  
			&& this.name === that.name
			&& this.variant === that.variant;
	}

	function resolvePlayerIcons(gamePlayers) {
		var players = {
			x : gamePlayers[0].Player__r,
			o : gamePlayers[1].Player__r
		};

		setIconIfUnset(players.x, DEFAULT_X_MARKER);
		setIconIfUnset(players.o, DEFAULT_O_MARKER);
		
		if (players.x.IconName__c === players.o.IconName__c) {
			players.o.IconName__c = DEFAULT_BACKUP_MARKER.name;
			players.o.IconVariant__c = DEFAULT_BACKUP_MARKER.variant;
		}
	}
	
	function setIconIfUnset(player, defaultMarker) {
		player.IconName__c = player.IconName__c || defaultMarker.name;
		player.IconVariant__c = player.IconVariant__c || defaultMarker.variant;
	}
	
	return {
		resolvePlayerIcons : resolvePlayerIcons
	};
}());

