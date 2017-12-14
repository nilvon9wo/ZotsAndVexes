public class ZV_CellOccupyResult {
    @AuraEnabled public List<ZV_Cell__c> updatedCellList {get; private set;}
    @AuraEnabled public String gameStatus = 'In Progress';
    @AuraEnabled public Id gameWinner;
    
    public ZV_CellOccupyResult(List<ZV_Cell__c> updatedCellList, ZV_Game__c game) {
    	this.updatedCellList = updatedCellList;
    	this.gameStatus = game.Status__c;
    	this.gameWinner = game.Winner__c;
    } 
}