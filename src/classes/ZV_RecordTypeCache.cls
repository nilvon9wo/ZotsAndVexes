public class ZV_RecordTypeCache {
	ZV_RecordTypeSelector recordTypeSelector;
    
    public ZV_RecordTypeCache(ZV_RecordTypeSelector recordTypeSelector) {
    	this.recordTypeSelector = recordTypeSelector; 
    }

    public ZV_RecordTypeCache() {
    	this(new ZV_RecordTypeSelector()); 
    }

    private static Set<SObjectType> REQUIRED_SOBJECT_TYPE_SET = new Set<SObjectType>();

	private static Map<Id, RecordType> RECORD_TYPE_BY_ID_MAP {
    	get {
    		if (RECORD_TYPE_BY_ID_MAP == null) {
    			RECORD_TYPE_BY_ID_MAP = (new ZV_RecordTypeCache()).buildRecordTypeByIdMap(); 
    		}
    		return RECORD_TYPE_BY_ID_MAP;
    	}
    }

    private static Map<Id, String> DEVELOPER_NAME_BY_ID_MAP {  
    	get {
    		if (DEVELOPER_NAME_BY_ID_MAP == null) {
    			DEVELOPER_NAME_BY_ID_MAP = new Map<Id, String>();
    			for (Id id : RECORD_TYPE_BY_ID_MAP.keySet()) {
    				DEVELOPER_NAME_BY_ID_MAP.put(id, RECORD_TYPE_BY_ID_MAP.get(id).DeveloperName);
    			}
    		}
    		return DEVELOPER_NAME_BY_ID_MAP; 
    	}
    }
    
    public Set<SObjectType> registerRequired(Set<SObjectType> requiredSObjectTypeSet) { 
    	REQUIRED_SOBJECT_TYPE_SET.addAll(requiredSObjectTypeSet);
    	return REQUIRED_SOBJECT_TYPE_SET;
    }
    
    public String getDeveloperNameFor(Id recordTypeId) {
    	return DEVELOPER_NAME_BY_ID_MAP.get(recordTypeId);
    }
    
    private Map<Id, RecordType> buildRecordTypeByIdMap() {
    	if (REQUIRED_SOBJECT_TYPE_SET == null) {
    		throw new ZV_RecordTypeCacheException('SObjectTypes must be registered on ZVRecordTypeCache before consuming.');
    	}
    	return new Map<Id, RecordType>(this.recordTypeSelector.selectFor(REQUIRED_SOBJECT_TYPE_SET));
    }
}