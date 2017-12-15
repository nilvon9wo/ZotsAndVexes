public class ZV_CellOccupyResult {
	ZV_GameStatusHelper gameStatusHelper; 
	
	ZV_CellOccupyResult(ZV_GameContext gameContext, ZV_GameStatusHelper gameStatusHelper) {
		this.gameStatusHelper = gameStatusHelper;

    	ZV_Game__c game = gameContext.game;
    	this.gameStatus = game.Status__c;
    	this.gameWinner = this.gameStatusHelper.isWon(game)
    		? gameContext.playerByIdMap.get(game.Winner__c).NickName__c
    		: null;
    	this.updatedCellList = gameContext.updatedCellList;
	}

    public ZV_CellOccupyResult(ZV_GameContext gameContext) {
    	this(gameContext, new ZV_GameStatusHelper());
    } 

    @AuraEnabled public String gameStatus {get; private set;}
    @AuraEnabled public String gameWinner {get; private set;}
    @AuraEnabled public List<ZV_Cell__c> updatedCellList {get; private set;}
}