public class ZV_PlayerTypeEnumHelper {
	ZV_RecordTypeCache recordTypeCache;
	
	public ZV_PlayerTypeEnumHelper(ZV_RecordTypeCache recordTypeCache) {
		this.recordTypeCache = recordTypeCache;
	}

	public ZV_PlayerTypeEnumHelper() {
		this(new ZV_RecordTypeCache());
	} 
	  
	
    public static Map<String, ZV_PlayerTypeEnum> NAME_TO_GAME_MAP { 
    	get {
    		Map<String, ZV_PlayerTypeEnum> nameToPlayerTypeMap = new Map<String, ZV_PlayerTypeEnum>();
    		for(ZV_PlayerTypeEnum player : ZV_PlayerTypeEnum.values()) {
    			nameToPlayerTypeMap.put(String.valueOf(player).toUpperCase(), player);
    		}
    		return nameToPlayerTypeMap;
    	} 
    	private set;
    }

    public ZV_PlayerTypeEnum convertToEnumFor(ZV_Player__c player) {
    	return this.convertToEnumFor(player.RecordTypeId);
    }
    
    public ZV_PlayerTypeEnum convertToEnumFor(Id recordTypeId) { 
    	String developerName = this.recordTypeCache.getDeveloperNameFor(recordTypeId);
    	return this.convertToEnumFor(developerName);
    }
}