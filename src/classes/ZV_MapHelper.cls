public with sharing class ZV_MapHelper {
    public Map<Id, SObject> buidMapBySpecifiedId(List<SObject> sObjectList, SObjectField sObjectIdField) {
    	Map<Id, SObject> sObjectByIdMap = new Map<Id, SObject>();
		for (SObject sObj : sObjectList) {
			sObjectByIdMap.put((Id) sObj.get(sObjectIdField), sObj);
		}    	
    	return sObjectByIdMap;
    }
    
    public Map<String, Set<ZV_Player__c>> buidMappedSetBySpecifiedString(List<ZV_Player__c> playerList, SObjectField sObjectStringField) {
    	Map<String, Set<ZV_Player__c>> playerSetByStringMap = new Map<String, Set<ZV_Player__c>>();
		for (ZV_Player__c player : playerList) {
			String key = (String) player.get(sObjectStringField);
			if (playerSetByStringMap.get(key) == null) { 
				playerSetByStringMap.put(key, new Set<ZV_Player__c>());
			}
			playerSetByStringMap.get(key).add(player);
		}    	
    	return playerSetByStringMap; 
    }
}