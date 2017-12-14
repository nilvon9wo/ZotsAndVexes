public class ZV_GamePlayerService {
	ZVG_GamesEnumHelper gamesEnumHelper;
	ZVG_GameLookup gameLookup;
	ZV_MapHelper mapHelper;
	
	public ZV_GamePlayerService(ZVG_GamesEnumHelper gamesEnumHelper, ZVG_GameLookup gameLookup, ZV_MapHelper mapHelper) {
		this.gamesEnumHelper = gamesEnumHelper;
		this.gameLookup = gameLookup;
		this.mapHelper = mapHelper;
	}

	public ZV_GamePlayerService() {
		this(new ZVG_GamesEnumHelper(), new ZVG_GameLookup(), new ZV_MapHelper());
	}
	
    public List<ZV_GamePlayer__c> attachPlayers (List<ZV_Game__c> gameList) {
    	Map<Id, List<ZV_Game__c>> gameListByGameRecordTypeIdMap = this.mapHelper.buidMappedListBySpecifiedId(gameList, ZV_Game__c.RecordTypeId);
    	
    	List<ZV_GamePlayer__c> allNewGamePlayerList = new List<ZV_GamePlayer__c>();
    	for (Id recordTypeId : gameListByGameRecordTypeIdMap.keySet()) {
    		ZVG_GameIntf gameInstance = this.gameLookup.getFor(this.gamesEnumHelper.convertToEnumFor(recordTypeId));
    		allNewGamePlayerList.addAll(gameInstance.attachPlayers(gameListByGameRecordTypeIdMap.get(recordTypeId)));
    	}  
    	return allNewGamePlayerList;   
    }

    public ZV_GamePlayer__c findNextGamePlayer(ZV_GameContext gameContext) {
    	ZV_GamePlayer__c currentNextPlayer = gameContext.nextGamePlayer;
    	Decimal currentPlayOrderValue = currentNextPlayer.PlayOrder__c;
    	
    	List<Decimal> availablePlayOrderValueList = new List<Decimal>(gameContext.gamePlayerByOrderMap.keySet()); 
    	availablePlayOrderValueList.sort();

		// We use the maximum to avoid looping through a large list of players.
    	Decimal maximum = availablePlayOrderValueList[availablePlayOrderValueList.size() - 1]; 
    	Decimal newPlayOrderValue = (currentPlayOrderValue == maximum) 
    		? availablePlayOrderValueList[0] 
    		: this.findNewPlayOrderValue(availablePlayOrderValueList, currentPlayOrderValue);
    	
    	ZV_GamePlayer__c newNextPlayer = (ZV_GamePlayer__c) gameContext.gamePlayerByOrderMap.get(newPlayOrderValue);
    	gameContext.game.NextPlayer__c = newNextPlayer.Id;
    	return newNextPlayer; 
    }

    private Decimal findNewPlayOrderValue(List<Decimal> availablePlayOrderValueList, Decimal currentPlayOrderValue) {
    	for (Decimal d: availablePlayOrderValueList) {
    		if (d > currentPlayOrderValue) { 
    			return d;
    		}
    	}
    	return availablePlayOrderValueList[0];
    }
    
    
}