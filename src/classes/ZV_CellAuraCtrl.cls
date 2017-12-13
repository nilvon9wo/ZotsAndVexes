public class ZV_CellAuraCtrl {
	ZV_CellService cellService;
	ZV_GameService gameService;
	ZV_RecordTypeCache recordTypeCache;   
	
	public ZV_CellAuraCtrl(
			ZV_CellService cellService, 
			ZV_GameService gameService,
			ZV_RecordTypeCache recordTypeCache
		) {
		this.cellService = cellService;
		this.gameService = gameService;
		this.recordTypeCache = recordTypeCache;
	}		

	public ZV_CellAuraCtrl() {
		this(
			new ZV_CellService(),  
			new ZV_GameService(), 
			new ZV_RecordTypeCache()
		);
	}		
 
    @AuraEnabled
    public static ZV_CellOccupyResult occupyCell(Id cellId) {
    	return (new ZV_CellAuraCtrl()).occupy(cellId);
    }
    	   
    public ZV_CellOccupyResult occupy(Id cellId) {
    	this.recordTypeCache.registerRequired(new Set<SObjectType>{
    		ZV_Game__c.SObjectType,
    		ZV_Player__c.SObjectType 
    	});
    	 
    	ZV_GameContext gameContext = new ZV_GameContext(cellId);
   		gameContext.currentGamePlayer = gameContext.gamePlayerByUserIdMap.get(gameContext.userId);
     	
    	gameContext.updatedCellList = this.cellService.occupyCells(gameContext);
    	return this.gameService.reactToOccupiedCell(gameContext);
    }
}