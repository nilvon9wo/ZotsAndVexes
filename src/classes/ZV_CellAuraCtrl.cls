public class ZV_CellAuraCtrl {
	F45_DML_GenericDml genericDml; 
	ZV_CellService cellService;
	ZV_GameService gameService;
	ZV_PlayerService playerService;
	ZV_RecordTypeCache recordTypeCache;   
	ZVR_RobotPlayerHelper robotPlayerHelper;
	
	public ZV_CellAuraCtrl(
			F45_DML_GenericDml genericDml, 
			ZV_CellService cellService, 
			ZV_GameService gameService,
			ZV_PlayerService playerService, 
			ZV_RecordTypeCache recordTypeCache,
			ZVR_RobotPlayerHelper robotPlayerHelper
		) {
		this.genericDml = genericDml;
		this.cellService = cellService;
		this.gameService = gameService;
		this.playerService = playerService;
		this.recordTypeCache = recordTypeCache;
		this.robotPlayerHelper = robotPlayerHelper;
	}		

	public ZV_CellAuraCtrl() {
		this(
			new F45_DML_GenericDml(),  
			new ZV_CellService(),  
			new ZV_GameService(), 
			new ZV_PlayerService(),
			new ZV_RecordTypeCache(),
			new ZVR_RobotPlayerHelper()
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
     	
    	List<ZV_Cell__c> updatedCellList = this.cellService.occupyCells(gameContext);
    	if (this.noGameWinner(gameContext)) {
			this.gameService.updateNextPlayer(gameContext);
			
			while(
					this.noGameWinner(gameContext)
					&& this.playerService.isRobot(gameContext.nextPlayer)
				) {
	    		gameContext.currentGamePlayer = gameContext.nextGamePlayer;
	    		updatedCellList.addAll(this.robotPlayerHelper.maneuver(gameContext));
	    		this.gameService.updateNextPlayer(gameContext);
			}
		
    	} 
    	
		this.genericDml.doUpsert(updatedCellList);    	  
		this.genericDml.doUpdate(new List<ZV_Game__c>{gameContext.game});
		return new ZV_CellOccupyResult(updatedCellList, gameContext.game); 
    }
    
    private Boolean noGameWinner(ZV_GameContext gameContext) {
    	this.gameService.declareWinner(gameContext);
    	return gameContext.game.Winner__c == null;
    }
}