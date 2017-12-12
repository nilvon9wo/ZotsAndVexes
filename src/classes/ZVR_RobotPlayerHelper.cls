public with sharing class ZVR_RobotPlayerHelper {
	ZVR_RobotPlayerLookup robotPlayerLookup;
	
	public ZVR_RobotPlayerHelper(ZVR_RobotPlayerLookup robotPlayerLookup) {
		this.robotPlayerLookup = robotPlayerLookup;
	}
	
	public ZVR_RobotPlayerHelper() {
		this(new ZVR_RobotPlayerLookup());
	}
	
    public List<ZV_Cell__c> maneuver(ZV_GameContext gameContext) {
    	return this.robotPlayerLookup.get(gameContext.currentPlayer.StrategyClassName__c)
    		.maneuver(gameContext);
    }
}