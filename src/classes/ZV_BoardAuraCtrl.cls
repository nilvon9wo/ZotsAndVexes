public class ZV_BoardAuraCtrl {
	F45_DML_GenericDml genericDml; 
	ZV_BoardSelector boardSelector;
	ZV_GamePlayerSelector gamePlayerSelector;
	ZV_RecordTypeCache recordTypeCache;   
	ZVG_GameLookup gameLookup;
	 
	public ZV_BoardAuraCtrl(
			F45_DML_GenericDml genericDml,
			ZV_BoardSelector boardSelector, 
			ZV_GamePlayerSelector gamePlayerSelector,
			ZV_RecordTypeCache recordTypeCache, 
			ZVG_GameLookup gameLookup
		) {
		this.genericDml = genericDml;
		this.boardSelector = boardSelector;
		this.gamePlayerSelector = gamePlayerSelector;
		this.recordTypeCache = recordTypeCache;
		this.gameLookup = gameLookup;
	} 

	public ZV_BoardAuraCtrl() {
		this(
			new F45_DML_GenericDml(), 
			new ZV_BoardSelector(), 
			new ZV_GamePlayerSelector(), 
			new ZV_RecordTypeCache(), 
			new ZVG_GameLookup()
		);
	}
	
    @AuraEnabled
    public static ZV_Board__c getBoard (Id boardId) {
    	return (new ZV_BoardAuraCtrl()).selectWithCells(boardId);
    }
    
    public ZV_Board__c selectWithCells (Id boardId) {
    	this.recordTypeCache.registerRequired(new Set<SObjectType>{
    		ZV_Game__c.SObjectType,
    		ZV_Player__c.SObjectType 
    	});
    	
    	ZV_GameContext gameContext = new ZV_GameContext(boardId);
    	if (gameContext.game.Status__c == 'New') {
    		this.gameLookup.getFor(gameContext.game).initializePlay(gameContext);
			this.genericDml.doUpsert(gameContext.updatedCellList);    	  
			this.genericDml.doUpdate(new List<ZV_Game__c>{gameContext.game});
    	} 
    	return gameContext.board;
    }
    
    @AuraEnabled
    public static List<ZV_GamePlayer__c> getPlayers (Id gameId) {
    	return (new ZV_CellContainerAuraCtrl()).selectGamePlayers(gameId);
    } 
    
    public List<ZV_GamePlayer__c> selectGamePlayers (Id gameId) {
    	return this.gamePlayerSelector.selectByGameId(gameId); 
    } 
}