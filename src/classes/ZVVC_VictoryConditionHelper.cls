public class ZVVC_VictoryConditionHelper {
	ZVVC_VictoryConditionLookup victoryConditionLookup;
	
	public ZVVC_VictoryConditionHelper(ZVVC_VictoryConditionLookup victoryConditionLookup) {
		this.victoryConditionLookup = victoryConditionLookup;
	}

	public ZVVC_VictoryConditionHelper() {
		this(new ZVVC_VictoryConditionLookup());
	}
	
    public Id checkForWinner(List<Type> victoryConditionList, ZV_GameContext gameContext) {
    	System.debug('##### ZVVC_VictoryConditionHelper victoryConditionList: ' + victoryConditionList);
    	System.debug('##### ZVVC_VictoryConditionHelper noGameWinner gameContext.game.Winner__c: ' + gameContext.game.Winner__c);
    	
    	for (Type victoryCondition: victoryConditionList) {
    	System.debug('##### ZVVC_VictoryConditionHelper victoryCondition: ' + victoryCondition);
    		ZVVC_VictoryConditionIntf victoryConditionInstance = this.victoryConditionLookup.get(victoryCondition);
    	System.debug('##### ZVVC_VictoryConditionHelper victoryConditionInstance: ' + victoryConditionInstance);
    		gameContext.game.Winner__c = victoryConditionInstance.checkForWinner(gameContext);
    	System.debug('##### ZVVC_VictoryConditionHelper gameContext.game.Winner__c: ' + gameContext.game.Winner__c);
    		
	    	if (gameContext.game.Winner__c != null) {
    	System.debug('##### ZVVC_VictoryConditionHelper WON!!!');
	    		gameContext.game.Status__c = 'Won';
	    		return gameContext.game.Winner__c;
	    	}
    	}
    	return null; 
    }
}