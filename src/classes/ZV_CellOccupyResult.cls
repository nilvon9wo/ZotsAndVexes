public class ZV_CellOccupyResult {
    @AuraEnabled public String gameStatus {get; private set;}
    @AuraEnabled public String gameWinner {get; private set;}
    @AuraEnabled public List<ZV_Cell__c> updatedCellList {get; private set;}
    
    public ZV_CellOccupyResult(ZV_GameContext gameContext) {
    	ZV_Game__c game = gameContext.game;
    	this.gameStatus = game.Status__c;
    	this.gameWinner = gameContext.playerByIdMap.get(game.Winner__c).NickName__c;
    	this.updatedCellList = gameContext.updatedCellList;
    } 
}