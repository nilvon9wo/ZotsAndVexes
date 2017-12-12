public with sharing class ZV_MapHelper {
    public Map<Id, SObject> buidMapBySpecifiedId(List<SObject> sObjectList, SObjectField sObjectIdField) {
    	Map<Id, SObject> sObjectByIdMap = new Map<Id, SObject>();
		for (SObject sObj : sObjectList) {
			sObjectByIdMap.put((Id) sObj.get(sObjectIdField), sObj);
		}    	
    	return sObjectByIdMap;
    }

    public Map<Decimal, SObject> buidMapBySpecifiedDecimal(List<SObject> sObjectList, SObjectField sObjectDecimalField) {
    	Map<Decimal, SObject> sObjectByIdMap = new Map<Decimal, SObject>();
		for (SObject sObj : sObjectList) {
			sObjectByIdMap.put((Decimal) sObj.get(sObjectDecimalField), sObj);
		}    	
    	return sObjectByIdMap;
    }
    
    public Map<Id, List<ZV_Game__c>> buidMappedListBySpecifiedId(List<ZV_Game__c> gameList, SObjectField sObjectIdField) {
    	Map<Id, List<ZV_Game__c>> gameListByIdMap = new Map<Id, List<ZV_Game__c>>();
		for (ZV_Game__c game : gameList) {
			String key = (Id) game.get(sObjectIdField);
			if (gameListByIdMap.get(key) == null) { 
				gameListByIdMap.put(key, new List<ZV_Game__c>());
			}
			gameListByIdMap.get(key).add(game);
		}    	
    	return gameListByIdMap; 
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