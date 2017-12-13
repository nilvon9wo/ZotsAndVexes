public class ZVSC_NoEmptyCells implements ZVSC_StalemateConditionIntf {
    public Boolean checkForStalemate(ZV_GameContext gameContext) {
    	return gameContext.unoccupiedCellSet.size() == 0;	
    }
}