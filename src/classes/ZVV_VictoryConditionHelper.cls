public class ZVV_VictoryConditionHelper {
	ZVV_VictoryConditionLookup victoryConditionLookup;
	
	public ZVV_VictoryConditionHelper(ZVV_VictoryConditionLookup victoryConditionLookup) {
		this.victoryConditionLookup = victoryConditionLookup;
	}

	public ZVV_VictoryConditionHelper() {
		this(new ZVV_VictoryConditionLookup());
	}
	
    public Id declareWinner(List<Type> victoryConditionList, ZV_GameContext gameContext) {
    	Integer index = 0;
    	while (gameContext.game.Winner__c == null && index < victoryConditionList.size()) {
    		ZVV_VictoryConditionIntf victoryConditionInstance = this.victoryConditionLookup.get(victoryConditionList[index]);
    		gameContext.game.Winner__c = victoryConditionInstance.declareWinner(gameContext); 
    	} 
    	
    	return gameContext.game.Winner__c; 
    }
}