public class ZV_CellOccupyValidator {
	ZVG_GameLookup gameLookup;
	
	public ZV_CellOccupyValidator(ZVG_GameLookup gameLookup) {
		this.gameLookup = gameLookup;
	}

	public ZV_CellOccupyValidator() {
		this(new ZVG_GameLookup());
	}
	
    public Boolean validate(ZV_GameCellContext gameCellContext) {
    	return this.isUserInGame(gameCellContext)
    		&& this.isUserNextPlayer(gameCellContext)
    		&& this.canUserOccupyCell(gameCellContext);
    }
    
    public Boolean isUserInGame(ZV_GameCellContext gameCellContext) {
    	if (!gameCellContext.playerUserIdSet.contains(gameCellContext.userId)) { 
    		throw new ZV_CellOccupyValidatorException(gameCellContext.userName + ' is not a player in game ' + gameCellContext.game.Name + '.');
    	}
    	return true;
    }
    
    public Boolean isUserNextPlayer(ZV_GameCellContext gameCellContext) {
    	Id nextGamePlayer = gameCellContext.nextGamePlayerId;
		Id currentUserGamePlayerId = gameCellContext.gamePlayerByUserIdMap
			.get(gameCellContext.userId).Id;
			
    	if (nextGamePlayer != currentUserGamePlayerId) {
    		ZV_Player__c nextPlayer = gameCellContext.gamePlayerByIdMap.get(nextGamePlayer).Player__r;
    		String nextPlayerNickName = nextPlayer.NickName__c; 
    		throw new ZV_CellOccupyValidatorException('The next player must be ' + nextPlayerNickName + ', not ' + gameCellContext.userNickName + '.');
    	}
    	return true;
    }
    
    public Boolean canUserOccupyCell(ZV_GameCellContext gameCellContext) {
    	return this.gameLookup.getFor(gameCellContext.game)
    		.canOccupyCell(gameCellContext);
    } 
} 