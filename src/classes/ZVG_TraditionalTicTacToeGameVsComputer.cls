public class ZVG_TraditionalTicTacToeGameVsComputer implements ZVG_GameIntf {  
	ZV_GamePlayerService gamePlayerService;  
	ZV_PlayerService playerService;  
	ZV_Randomizer randomizer;
	ZVR_RobotPlayerHelper robotPlayerHelper;
	ZVSC_StalemateConditionHelper stalemateConditionHelper;
	ZVVC_VictoryConditionHelper victoryConditionHelper;
	
	public ZVG_TraditionalTicTacToeGameVsComputer(
			ZV_GamePlayerService gamePlayerService,
			ZV_PlayerService playerService, 
			ZV_Randomizer randomizer,
			ZVR_RobotPlayerHelper robotPlayerHelper, 
			ZVSC_StalemateConditionHelper stalemateConditionHelper,
			ZVVC_VictoryConditionHelper victoryConditionHelper
		) {
		this.gamePlayerService = gamePlayerService;
		this.playerService = playerService;
		this.randomizer = randomizer;
		this.robotPlayerHelper = robotPlayerHelper;
		this.stalemateConditionHelper = stalemateConditionHelper;
		this.victoryConditionHelper = victoryConditionHelper;
	}

	public ZVG_TraditionalTicTacToeGameVsComputer() {
		this(
			new ZV_GamePlayerService(),
			new ZV_PlayerService(), 
			new ZV_Randomizer(), 
			new ZVR_RobotPlayerHelper(),
			new ZVSC_StalemateConditionHelper(), 
			new ZVVC_VictoryConditionHelper()
		);
	}
 
	private static List<Type> VICTORY_CONDITION_LIST = new List<Type>{
		ZVVC_FullColumn.class,
		ZVVC_FullRow.class,
		ZVVC_LowerLeftCornerToUpperRightCorner.class,
		ZVVC_UpperLeftCornerToLowerRightCorner.class
	};

	private static List<Type> STALEMATE_CONDITION_LIST = new List<Type>{
		ZVSC_NoEmptyCells.class
	};


    public List<ZV_GamePlayer__c> attachPlayers (List<ZV_Game__C> gameList) {
    	List<ZV_GamePlayer__c> gamePlayerList = new List<ZV_GamePlayer__c>();
    	for (ZV_Game__C game : gameList) {
    		gamePlayerList.addAll(this.attachPlayers(game));
    	} 
    	return gamePlayerList;
    }
    
    private List<ZV_GamePlayer__c> attachPlayers (ZV_Game__C game) {
    	List<ZV_GamePlayer__c> gamePlayerList = new List<ZV_GamePlayer__c>();
    	Boolean humanGoesFirst = this.randomizer.getRandomBoolean();
    	gamePlayerList.add(new ZV_GamePlayer__c(
    		Game__c = game.id,
    		Player__c = playerService.getHumanPlayerId(game),
    		PlayOrder__c = humanGoesFirst ? 1 : 2
    	));
    	  
    	Boolean robotGoesFirst = !humanGoesFirst;
    	gamePlayerList.add(new ZV_GamePlayer__c(
    		Game__c = game.id,
    		Player__c = playerService.getRobotPlayerId(game),
    		PlayOrder__c = robotGoesFirst ? 1 : 2
    	));
    	return gamePlayerList; 
    }
    
    public ZV_GameContext initializePlay(ZV_GameContext gameContext) {
		if (this.playerService.isRobot(gameContext.nextPlayer)) {
    		gameContext.currentGamePlayer = gameContext.nextGamePlayer;
    		gameContext.updatedCellList = this.robotPlayerHelper.maneuver(gameContext);
			this.gamePlayerService.findNextGamePlayer(gameContext);
		}    	
    	return gameContext;
    }
    
	public Boolean canOccupyCell(ZV_GameContext gameContext) {
		Boolean canOccupy = gameContext.cell.Occupant__c == null;
		if (!canOccupy) {
			ZV_Player__c occupant = gameContext.gamePlayerByIdMap.get(gameContext.cell.Occupant__c).Player__r;
			throw new ZVG_TraditionalTicTacToeGameException('Cell is already occupied by ' + occupant.Nickname__c);
		}
		return canOccupy;
	}
	
	public List<ZV_Cell__c> occupyCells(ZV_GameContext gameContext) {
		gameContext.cell.Occupant__c = gameContext.gamePlayerByUserIdMap.get(gameContext.userId).Id;
		return new List<ZV_Cell__c>{gameContext.cell};
	}
	 
	public Id checkForWinner(ZV_GameContext gameContext) {
		return this.victoryConditionHelper.checkForWinner(VICTORY_CONDITION_LIST, gameContext); 
	}
	
	public Boolean checkForStalemate(ZV_GameContext gameContext) {
		return this.stalemateConditionHelper.checkForStalemate(STALEMATE_CONDITION_LIST, gameContext); 
	}    
}