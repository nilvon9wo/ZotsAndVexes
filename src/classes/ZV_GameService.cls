public class ZV_GameService {
	ZVG_GameLookup gameLookup;

	public ZV_GameService(ZVG_GameLookup gameLookup) {
		this.gameLookup = gameLookup;
	}

	public ZV_GameService() {
		this(new ZVG_GameLookup());
	}
	
    public ZV_GamePlayer__c updateNextPlayer(ZV_GameContext gameContext) {
    	ZV_GamePlayer__c currentNextPlayer = gameContext.nextGamePlayer;
    	Decimal currentPlayOrderValue = currentNextPlayer.PlayOrder__c;
    	
    	List<Decimal> availablePlayOrderValueList = new List<Decimal>(gameContext.gamePlayerByOrderMap.keySet()); 
    	availablePlayOrderValueList.sort();

		// We use the maximum to avoid looping through a large list of players.
    	Decimal maximum = availablePlayOrderValueList[availablePlayOrderValueList.size() - 1]; 
    	Decimal newPlayOrderValue = (currentPlayOrderValue == maximum) 
    		? availablePlayOrderValueList[0]
    		: findNewPlayOrderValue(availablePlayOrderValueList, currentPlayOrderValue);
    	
    	ZV_GamePlayer__c newNextPlayer = gameContext.gamePlayerByOrderMap.get(newPlayOrderValue);
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
     
    public Id declareWinner(ZV_GameContext gameContext) { 
		return this.gameLookup.getFor(gameContext.game)
    			.declareWinner(gameContext);     	 
    }
}