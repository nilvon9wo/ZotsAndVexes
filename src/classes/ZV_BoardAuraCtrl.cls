public class ZV_BoardAuraCtrl {
	ZV_GamePlayerSelector gamePlayerSelector;
	ZV_GameService gameService;
	ZV_RecordTypeCache recordTypeCache;   
		  
	public ZV_BoardAuraCtrl(
			ZV_GamePlayerSelector gamePlayerSelector,
			ZV_GameService gameService, 
			ZV_RecordTypeCache recordTypeCache 
		) {
		this.gamePlayerSelector = gamePlayerSelector;
		this.gameService = gameService;
		this.recordTypeCache = recordTypeCache;
	} 

	public ZV_BoardAuraCtrl() {
		this(
			new ZV_GamePlayerSelector(), 
			new ZV_GameService(),
			new ZV_RecordTypeCache()
		);
	}
	
    @AuraEnabled
    public static ZV_Board__c getBoard (Id boardId) {
    	return (new ZV_BoardAuraCtrl()).initializePlay(boardId);
    }
    
    @testVisible
    private ZV_Board__c initializePlay (Id boardId) {
    	this.recordTypeCache.registerRequired(new Set<SObjectType>{
    		ZV_Game__c.SObjectType,
    		ZV_Player__c.SObjectType 
    	});
    	
    	ZV_GameContext gameContext = new ZV_GameContext(boardId);
   		this.gameService.initializePlay(gameContext);
    	return gameContext.board;
    }
    
    @AuraEnabled
    public static List<ZV_GamePlayer__c> getPlayers (Id gameId) {
    	return (new ZV_CellContainerAuraCtrl()).selectGamePlayers(gameId);
    } 
    
    @testVisible
    private List<ZV_GamePlayer__c> selectGamePlayers (Id gameId) {
    	return this.gamePlayerSelector.selectByGameId(gameId); 
    } 
}