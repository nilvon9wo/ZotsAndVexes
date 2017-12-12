public class ZVG_TraditionalTicTacToeGameVsComputer implements ZVG_GameIntf {
	ZV_PlayerService playerService;  
	ZV_Randomizer randomizer;
	
	public ZVG_TraditionalTicTacToeGameVsComputer(ZV_PlayerService playerService, ZV_Randomizer randomizer) {
		this.playerService = playerService;
		this.randomizer = randomizer;
	}

	public ZVG_TraditionalTicTacToeGameVsComputer() {
		this(new ZV_PlayerService(), new ZV_Randomizer());
	}

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
    
	public Boolean canOccupyCell(ZV_GameCellContext gameCellContext) {
		return gameCellContext.cell.Occupant__c == null;
	}
	
	
	public List<ZV_Cell__c> occupyCells(ZV_GameCellContext gameCellContext) {
		gameCellContext.cell.Occupant__c = gameCellContext.gamePlayerByUserIdMap.get(gameCellContext.userId).Id;
		return new List<ZV_Cell__c>{gameCellContext.cell};
	}    
}