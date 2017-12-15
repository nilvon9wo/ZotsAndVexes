public class ZV_GameService {  
	F45_DML_GenericDml genericDml;
	ZV_GamePlayerService gamePlayerService; 
	ZV_GameStatusHelper gameStatusHelper;
	ZV_PlayerService playerService;
	ZVG_GameLookup gameLookup;
	ZVR_RobotPlayerHelper robotPlayerHelper;
 
	public ZV_GameService(
			F45_DML_GenericDml genericDml,
			ZV_GamePlayerService gamePlayerService,
			ZV_GameStatusHelper gameStatusHelper, 
			ZV_PlayerService playerService, 
			ZVG_GameLookup gameLookup,
			ZVR_RobotPlayerHelper robotPlayerHelper
		) { 
		this.genericDml = genericDml;
		this.gamePlayerService = gamePlayerService;
		this.gameStatusHelper = gameStatusHelper;
		this.playerService = playerService;
		this.gameLookup = gameLookup;
		this.robotPlayerHelper = robotPlayerHelper;
	}

	public ZV_GameService() {
		this(
			new F45_DML_GenericDml(),  
			new ZV_GamePlayerService(),
			new ZV_GameStatusHelper(),
			new ZV_PlayerService(),
			new ZVG_GameLookup(),
			new ZVR_RobotPlayerHelper()
		);
	}		
	
    public ZV_CellOccupyResult reactToOccupiedCell(ZV_GameContext gameContext) {
    	if (this.isInProgress(gameContext)) {
			this.gamePlayerService.findNextGamePlayer(gameContext);

			while(
					this.isInProgress(gameContext)
					&& this.playerService.isRobot(gameContext.nextPlayer) 
				) {
	    		gameContext.currentGamePlayer = gameContext.nextGamePlayer;
	    		gameContext.updatedCellList.addAll(this.robotPlayerHelper.maneuver(gameContext));
	    		this.gamePlayerService.findNextGamePlayer(gameContext);
			}
    	} 
		this.genericDml.doUpdate(gameContext.updatedCellList);    	  
		this.genericDml.doUpdate(new List<ZV_Game__c>{gameContext.game});
		return new ZV_CellOccupyResult(gameContext); 
    }

	public ZV_GameContext initializePlay (ZV_GameContext gameContext) {
    	if (this.gameStatusHelper.isNew(gameContext.game)) {
			gameLookup.getFor(gameContext.game).initializePlay(gameContext);
			gameContext.game.Status__c = ZV_GameStatusHelper.IN_PROGRESS;
			genericDml.doUpdate(gameContext.updatedCellList);
			genericDml.doUpdate(new List<ZV_Game__c>{gameContext.game});
    	}
		return gameContext;
	}

    public Boolean isInProgress(ZV_GameContext gameContext) {
    	return noGameWinner(gameContext)
    		&& noStalemate(gameContext)
    		&& this.gameStatusHelper.isInProgress(gameContext.game);
    }
    
    private Boolean noGameWinner(ZV_GameContext gameContext) {
    	this.gameLookup.getFor(gameContext.game).checkForWinner(gameContext);
    	return gameContext.game.Winner__c == null;
    } 
     
    private Boolean noStalemate(ZV_GameContext gameContext) {
    	this.gameLookup.getFor(gameContext.game).checkForStalemate(gameContext);
    	return !this.gameStatusHelper.isStalemate(gameContext.game);
    } 
}