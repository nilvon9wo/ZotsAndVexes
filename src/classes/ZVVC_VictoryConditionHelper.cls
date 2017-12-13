public class ZVVC_VictoryConditionHelper {
	ZVVC_VictoryConditionLookup victoryConditionLookup;
	
	public ZVVC_VictoryConditionHelper(ZVVC_VictoryConditionLookup victoryConditionLookup) {
		this.victoryConditionLookup = victoryConditionLookup;
	}

	public ZVVC_VictoryConditionHelper() {
		this(new ZVVC_VictoryConditionLookup());
	}
	
    public Id checkForWinner(List<Type> victoryConditionList, ZV_GameContext gameContext) {
    	for (Type victoryCondition: victoryConditionList) {
    		ZVVC_VictoryConditionIntf victoryConditionInstance = this.victoryConditionLookup.get(victoryCondition);
    		gameContext.game.Winner__c = victoryConditionInstance.checkForWinner(gameContext);
    		
	    	if (gameContext.game.Winner__c != null) {
	    		gameContext.game.Status__c = 'Won';
	    		return gameContext.game.Winner__c;
	    	}
    	}
    	return null; 
    }
}