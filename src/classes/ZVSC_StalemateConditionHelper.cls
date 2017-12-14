public class ZVSC_StalemateConditionHelper { 
	ZVSC_StalemateConditionLookup stalemateConditionLookup; 
	
	public ZVSC_StalemateConditionHelper(ZVSC_StalemateConditionLookup stalemateConditionLookup) {
		this.stalemateConditionLookup = stalemateConditionLookup;
	}

	public ZVSC_StalemateConditionHelper() {
		this(new ZVSC_StalemateConditionLookup());
	}
	
    public Boolean checkForStalemate(List<Type> stalemateConditionList, ZV_GameContext gameContext) {
    	for (Type stalemateCondition: stalemateConditionList) {
    		ZVSC_StalemateConditionIntf stalemateConditionInstance = this.stalemateConditionLookup.get(stalemateCondition);
    		Boolean hasStalemate = stalemateConditionInstance.checkForStalemate(gameContext);
    		  
	    	if (hasStalemate) {
	    		gameContext.game.Status__c = 'Stalemate';
	    		return hasStalemate;
	    	}
    	}
    	return null; 
    }
}