public class ZVR_RandomOpenCellStrategy implements ZVR_RobotPlayerIntf {
	ZV_Randomizer randomizer;
	
	ZVR_RandomOpenCellStrategy(ZV_Randomizer randomizer) {
		this.randomizer = randomizer;
	}
	
	ZVR_RandomOpenCellStrategy() {
		this(new ZV_Randomizer());
	}
	
	public List<ZV_Cell__c> maneuver(ZV_GameContext gameContext) {
		return new List<ZV_Cell__c>{
			this.randomizer.getRandomMember(gameContext.unoccupiedCellSet)
		}; 
	}    
}