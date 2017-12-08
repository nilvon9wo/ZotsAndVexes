public class ZV_BoardAuraCtrl {
	ZV_BoardSelector boardSelector;
	ZV_GamePlayerSelector gamePlayerSelector;
	
	public ZV_BoardAuraCtrl(ZV_BoardSelector boardSelector, ZV_GamePlayerSelector gamePlayerSelector) {
		this.boardSelector = boardSelector;
		this.gamePlayerSelector = gamePlayerSelector;
	}

	public ZV_BoardAuraCtrl() {
		this(new ZV_BoardSelector(), new ZV_GamePlayerSelector());
	}
	
    @AuraEnabled
    public static ZV_Board__c getBoard (Id boardId) {
    	return (new ZV_BoardAuraCtrl()).selectWithCells(boardId);
    }
    
    public ZV_Board__c selectWithCells (Id boardId) {
    	return this.boardSelector.selectWithCells(new Set<Id>{boardId})[0];
    }
    
    @AuraEnabled
    public static List<ZV_GamePlayer__c> getPlayers (Id gameId) {
    	return (new ZV_CellContainerAuraCtrl()).selectGamePlayers(gameId);
    } 
    
    public List<ZV_GamePlayer__c> selectGamePlayers (Id gameId) {
    	return this.gamePlayerSelector.selectByGameId(gameId); 
    } 
}