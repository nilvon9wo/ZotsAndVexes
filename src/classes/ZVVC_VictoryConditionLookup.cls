public class ZVVC_VictoryConditionLookup {
	private static Map<Type, ZVVC_VictoryConditionIntf> INSTANCE_BY_TYPE_MAP = new Map<Type, ZVVC_VictoryConditionIntf>(); 
	
    public ZVVC_VictoryConditionIntf get(Type victoryConditionClass) {
    	if (INSTANCE_BY_TYPE_MAP.get(victoryConditionClass) == null) {
    		INSTANCE_BY_TYPE_MAP.put(victoryConditionClass, (ZVVC_VictoryConditionIntf) victoryConditionClass.newInstance());
    	} 
    	return INSTANCE_BY_TYPE_MAP.get(victoryConditionClass);
    }
}