public class ZVR_RandomOpenCellStrategy implements ZVR_RobotPlayerIntf {
	ZV_Randomizer randomizer;
	
	public ZVR_RandomOpenCellStrategy(ZV_Randomizer randomizer) {
		this.randomizer = randomizer;
	}
	
	public ZVR_RandomOpenCellStrategy() {
		this(new ZV_Randomizer());
	}
	
	public List<ZV_Cell__c> maneuver(ZV_GameContext gameContext) {
    	ZV_Cell__c randomCell = this.randomizer.getRandomMember(gameContext.unoccupiedCellSet);
    	randomCell.Occupant__c = gameContext.currentGamePlayer.Id;
		return new List<ZV_Cell__c>{randomCell}; 
	}    
}