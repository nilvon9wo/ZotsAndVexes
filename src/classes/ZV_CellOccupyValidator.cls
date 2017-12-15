public class ZV_CellOccupyValidator {
	ZV_GameStatusHelper gameStatusHelper;
	ZVG_GameLookup gameLookup;
	
	public ZV_CellOccupyValidator(ZV_GameStatusHelper gameStatusHelper, ZVG_GameLookup gameLookup) {
		this.gameStatusHelper = gameStatusHelper;
		this.gameLookup = gameLookup;
	}

	public ZV_CellOccupyValidator() { 
		this(new ZV_GameStatusHelper(), new ZVG_GameLookup());
	}
	
    public Boolean validate(ZV_GameContext gameContext) {
    	return this.isGameInProgress(gameContext)
    		&& this.isUserInGame(gameContext)
    		&& this.isUserNextPlayer(gameContext)
    		&& this.canUserOccupyCell(gameContext);
    }
    
    public Boolean isGameInProgress(ZV_GameContext gameContext) {
    	if (!this.gameStatusHelper.isInProgress(gameContext.game)) { 
    		throw new ZV_CellOccupyValidatorException(
    			'This game has a status of ' + gameContext.game.Status__c + ', ' 
    			+ 'not "' + ZV_GameStatusHelper.IN_PROGRESS + '".'
    		);
    	}
    	return true;
    }
    
    public Boolean isUserInGame(ZV_GameContext gameContext) {
    	if (!gameContext.playerUserIdSet.contains(gameContext.userId)) { 
    		throw new ZV_CellOccupyValidatorException(gameContext.userName + ' is not a player in game ' + gameContext.game.Name + '.');
    	}
    	return true;
    }
    
    public Boolean isUserNextPlayer(ZV_GameContext gameContext) {
    	Id nextGamePlayer = gameContext.nextGamePlayerId;
		Id currentUserGamePlayerId = gameContext.gamePlayerByUserIdMap
			.get(gameContext.userId).Id;
			
    	if (nextGamePlayer != currentUserGamePlayerId) {
    		ZV_Player__c nextPlayer = gameContext.gamePlayerByIdMap.get(nextGamePlayer).Player__r;
    		String nextPlayerNickName = nextPlayer.NickName__c; 
    		throw new ZV_CellOccupyValidatorException('The next player must be ' + nextPlayerNickName + ', not ' + gameContext.userNickName + '.');
    	}
    	return true;
    }
    
    public Boolean canUserOccupyCell(ZV_GameContext gameContext) {
    	return this.gameLookup.getFor(gameContext.game)
    		.canOccupyCell(gameContext);
    } 
}