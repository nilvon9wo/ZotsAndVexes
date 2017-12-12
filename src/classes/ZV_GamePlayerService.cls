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
}