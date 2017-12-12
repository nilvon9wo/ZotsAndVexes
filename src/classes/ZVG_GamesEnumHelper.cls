public class ZVG_GamesEnumHelper {
	ZV_RecordTypeCache recordTypeCache;
	
	public ZVG_GamesEnumHelper(ZV_RecordTypeCache recordTypeCache) {
		this.recordTypeCache = recordTypeCache;
	}

	public ZVG_GamesEnumHelper() {
		this(new ZV_RecordTypeCache());
	} 
	  
	
    public static Map<String, ZVG_GamesEnum> NAME_TO_GAME_MAP { 
    	get {
    		Map<String, ZVG_GamesEnum> nameToGameMap = new Map<String, ZVG_GamesEnum>();
    		for(ZVG_GamesEnum game : ZVG_GamesEnum.values()) {
    			nameToGameMap.put(String.valueOf(game).toUpperCase(), game);
    		}
    		return nameToGameMap;
    	} 
    	private set;
    }

    public ZVG_GamesEnum convertToEnumFor(ZV_Game__c game) {
    	return this.convertToEnumFor(game.RecordTypeId);
    }
    
    public ZVG_GamesEnum convertToEnumFor(Id recordTypeId) { 
    	String developerName = this.recordTypeCache.getDeveloperNameFor(recordTypeId);
    	return this.convertToEnumFor(developerName);
    }

    public ZVG_GamesEnum convertToEnumFor(String recordTypeName) {
    	String mangledName = recordTypeName.toUpperCase().replace(' ', '_');
    	return NAME_TO_GAME_MAP.get(mangledName);
    }
}