public class ZVG_TraditionalTicTacToeGameVsComputer implements ZVG_GameIntf { 
	ZV_PlayerService playerService;  
	ZV_Randomizer randomizer;
	ZVV_VictoryConditionHelper victoryConditionHelper;
	
	public ZVG_TraditionalTicTacToeGameVsComputer(
			ZV_PlayerService playerService, 
			ZV_Randomizer randomizer, 
			ZVV_VictoryConditionHelper victoryConditionHelper
		) {
		this.playerService = playerService;
		this.randomizer = randomizer;
		this.victoryConditionHelper = victoryConditionHelper;
	}

	public ZVG_TraditionalTicTacToeGameVsComputer() {
		this(new ZV_PlayerService(), new ZV_Randomizer(), new ZVV_VictoryConditionHelper());
	}
 
	private static List<Type> VICTORY_CONDITION_LIST = new List<Type>{
/*		 
		ZVV_FullHorizontalRow.class,
		ZVV_FullVeriticalRow.class,
		ZVV_UpperLeftCornerToLowerRightCorner.class,
		ZVV_LowerLeftCornerToUpperRightCorner.class
*/		
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
    
	public Boolean canOccupyCell(ZV_GameContext gameContext) {
		return gameContext.cell.Occupant__c == null;
	}
	
	public List<ZV_Cell__c> occupyCells(ZV_GameContext gameContext) {
		gameContext.cell.Occupant__c = gameContext.gamePlayerByUserIdMap.get(gameContext.userId).Id;
		return new List<ZV_Cell__c>{gameContext.cell};
	}
	 
	public Id declareWinner(ZV_GameContext gameContext) {
		return this.victoryConditionHelper.declareWinner(VICTORY_CONDITION_LIST, gameContext); 
	}    
}