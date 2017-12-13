public class ZVSC_StalemateConditionLookup {
	private static Map<Type, ZVSC_StalemateConditionIntf> INSTANCE_BY_TYPE_MAP = new Map<Type, ZVSC_StalemateConditionIntf>(); 
	
    public ZVSC_StalemateConditionIntf get(System.Type stalemateConditionClass) {
    	if (INSTANCE_BY_TYPE_MAP.get(stalemateConditionClass) == null) {
    		INSTANCE_BY_TYPE_MAP.put(stalemateConditionClass, (ZVSC_StalemateConditionIntf) stalemateConditionClass.newInstance());
    	} 
    	return INSTANCE_BY_TYPE_MAP.get(stalemateConditionClass);
    }
}