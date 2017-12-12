public class ZVR_RobotPlayerLookup {
	private static Map<String, ZVR_RobotPlayerIntf> INSTANCE_BY_NAME_MAP = new Map<String, ZVR_RobotPlayerIntf>(); 
	
    public ZVR_RobotPlayerIntf get(String strategyName) {
    	if (INSTANCE_BY_NAME_MAP.get(strategyName) == null) {
    		Type robotPlayer = Type.forName(strategyName);
    		INSTANCE_BY_NAME_MAP.put(strategyName, (ZVR_RobotPlayerIntf) robotPlayer.newInstance());
    	} 
    	return INSTANCE_BY_NAME_MAP.get(strategyName);
    }
}