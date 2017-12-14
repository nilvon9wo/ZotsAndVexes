public class ZV_CellContainerAuraCtrl {
	ZV_GamePlayerSelector gamePlayerSelector;
	
	public ZV_CellContainerAuraCtrl(ZV_GamePlayerSelector gamePlayerSelector) {
		this.gamePlayerSelector = gamePlayerSelector;
	}

	public ZV_CellContainerAuraCtrl() {
		this(new ZV_GamePlayerSelector());
	}
	
    @AuraEnabled
    public static List<ZV_GamePlayer__c> getPlayers (Id gameId) {
    	return (new ZV_CellContainerAuraCtrl()).selectGamePlayers(gameId);
    } 
    
    public List<ZV_GamePlayer__c> selectGamePlayers (Id gameId) {
    	return this.gamePlayerSelector.selectByGameId(gameId); 
    } 
}