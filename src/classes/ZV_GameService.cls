public class ZV_GameService {  
	F45_DML_GenericDml genericDml; 
	ZV_PlayerService playerService;
	ZVG_GameLookup gameLookup;
	ZVR_RobotPlayerHelper robotPlayerHelper;

	public ZV_GameService(
			F45_DML_GenericDml genericDml, 
			ZV_PlayerService playerService, 
			ZVG_GameLookup gameLookup,
			ZVR_RobotPlayerHelper robotPlayerHelper
		) { 
		this.genericDml = genericDml;
		this.playerService = playerService;
		this.gameLookup = gameLookup;
		this.robotPlayerHelper = robotPlayerHelper;
	}

	public ZV_GameService() {
		this(
			new F45_DML_GenericDml(),  
			new ZV_PlayerService(),
			new ZVG_GameLookup(),
			new ZVR_RobotPlayerHelper()
		);
	}		
	
    public ZV_CellOccupyResult reactToOccupiedCell(ZV_GameContext gameContext) {
    	if (this.noGameWinner(gameContext)) {
			this.updateNextPlayer(gameContext);

			while(
					this.noGameWinner(gameContext)
					&& this.playerService.isRobot(gameContext.nextPlayer) 
				) {
	    		gameContext.currentGamePlayer = gameContext.nextGamePlayer;
	    		gameContext.updatedCellList.addAll(this.robotPlayerHelper.maneuver(gameContext));
	    		this.updateNextPlayer(gameContext);
			}
    	} 

		this.genericDml.doUpsert(gameContext.updatedCellList);    	  
		this.genericDml.doUpdate(new List<ZV_Game__c>{gameContext.game});
		return new ZV_CellOccupyResult(gameContext.updatedCellList, gameContext.game); 
    }

    private ZV_GamePlayer__c updateNextPlayer(ZV_GameContext gameContext) {
    	ZV_GamePlayer__c currentNextPlayer = gameContext.nextGamePlayer;
    	Decimal currentPlayOrderValue = currentNextPlayer.PlayOrder__c;
    	
    	List<Decimal> availablePlayOrderValueList = new List<Decimal>(gameContext.gamePlayerByOrderMap.keySet()); 
    	availablePlayOrderValueList.sort();

		// We use the maximum to avoid looping through a large list of players.
    	Decimal maximum = availablePlayOrderValueList[availablePlayOrderValueList.size() - 1]; 
    	Decimal newPlayOrderValue = (currentPlayOrderValue == maximum) 
    		? availablePlayOrderValueList[0]
    		: findNewPlayOrderValue(availablePlayOrderValueList, currentPlayOrderValue);
    	
    	ZV_GamePlayer__c newNextPlayer = (ZV_GamePlayer__c) gameContext.gamePlayerByOrderMap.get(newPlayOrderValue);
    	gameContext.game.NextPlayer__c = newNextPlayer.Id;
    	return newNextPlayer; 
    }
    
    private Decimal findNewPlayOrderValue(List<Decimal> availablePlayOrderValueList, Decimal currentPlayOrderValue) {
    	for (Decimal d: availablePlayOrderValueList) {
    		if (d > currentPlayOrderValue) { 
    			return d;
    		}
    	}
    	return availablePlayOrderValueList[0];
    }
    
    public Boolean isInProgress(ZV_GameContext gameContext) {
    	return noGameWinner(gameContext)
    		&& noStalemate(gameContext);
    }
    
    private Boolean noGameWinner(ZV_GameContext gameContext) {
    	this.gameLookup.getFor(gameContext.game).checkForWinner(gameContext);
    	return gameContext.game.Winner__c == null;
    } 
     
    private Boolean noStalemate(ZV_GameContext gameContext) {
    	this.gameLookup.getFor(gameContext.game).checkForStalemate(gameContext);
    	return gameContext.game.Status__c == 'Stalemate';
    } 
}