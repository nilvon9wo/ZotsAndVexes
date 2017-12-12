public class ZVV_VictoryConditionLookup {
	private static Map<Type, ZVV_VictoryConditionIntf> INSTANCE_BY_TYPE_MAP = new Map<Type, ZVV_VictoryConditionIntf>(); 
	
    public ZVV_VictoryConditionIntf get(Type victoryConditionClass) {
    	if (INSTANCE_BY_TYPE_MAP.get(victoryConditionClass) == null) {
    		INSTANCE_BY_TYPE_MAP.put(victoryConditionClass, (ZVV_VictoryConditionIntf) victoryConditionClass.newInstance());
    	} 
    	return INSTANCE_BY_TYPE_MAP.get(victoryConditionClass);
    }
}