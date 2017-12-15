public class ZV_CellOccupyResult {
	ZV_GameStatusHelper gameStatusHelper; 
	
	ZV_CellOccupyResult(ZV_GameContext gameContext, ZV_GameStatusHelper gameStatusHelper) {
		this.gameStatusHelper = gameStatusHelper;

    	ZV_Game__c game = gameContext.game;
    	this.gameStatus = game.Status__c;
    	if (this.gameStatusHelper.isWon(game)) {
    		this.winnerNickName = gameContext.playerByIdMap.get(game.Winner__c).NickName__c;
    		this.winnerGamePlayerId = ((ZV_GamePlayer__c) gameContext.gamePlayerByPlayerIdMap.get(game.Winner__c)).Id;
    	}
    	this.updatedCellList = gameContext.updatedCellList;
	}

    public ZV_CellOccupyResult(ZV_GameContext gameContext) {
    	this(gameContext, new ZV_GameStatusHelper());
    } 

    @AuraEnabled public String gameStatus {get; private set;}
    @AuraEnabled public String winnerNickName {get; private set;}
    @AuraEnabled public Id winnerGamePlayerId {get; private set;}
    @AuraEnabled public List<ZV_Cell__c> updatedCellList {get; private set;}
}