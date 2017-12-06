public with sharing class ZV_PlayerRepository {
	ZV_MapHelper mapHelper;
	ZV_PlayerSelector playerSelector;
	ZV_Randomizer randomizer;
 	ZV_SetHelper setHelper;
	ZV_UserSelector userSelector;

 	public ZV_PlayerRepository(
 			ZV_MapHelper mapHelper,
 			ZV_PlayerSelector playerSelector, 
 			ZV_Randomizer randomizer, 
 			ZV_SetHelper setHelper, 
 			ZV_UserSelector userSelector
 		) {
 		this.mapHelper = mapHelper;
 		this.playerSelector = playerSelector;
 		this.randomizer = randomizer;
 		this.setHelper = setHelper; 
 		this.userSelector = userSelector;
 	}
  
 	public ZV_PlayerRepository() {
 		this(
 			new ZV_MapHelper(),
 			new ZV_PlayerSelector(), 
 			new ZV_Randomizer(), 
 			new ZV_SetHelper(), 
 			new ZV_UserSelector()
 		);
 	}
 
	private static String DEFAULT_ROBOT_STRATEGY = 'Idiot';
	private static List<ZV_Player__c> PLAYER_LIST;
	
	// Mapped as SObject because of Apex limitation
	private static MAP<Id, SObject> HUMAN_PLAYER_BY_USER_ID_MAP;
	 
	private static MAP<String, Set<ZV_Player__c>> ROBOT_PLAYER_BY_STRATEGY_SET_MAP; 

	public ZV_PlayerCollections loadPlayers (List<ZV_Game__c> gameList) {
		Set<Id> humanPlayerUserIdSet = setHelper.createIdSet(gameList, ZV_Game__c.OwnerId);
		Set<String> robotStrategySet = new Set<String>{DEFAULT_ROBOT_STRATEGY}; 
		List<ZV_Player__c> existingPlayerList = this.playerSelector.selectByUserIdOrStrategyName(humanPlayerUserIdSet, robotStrategySet);
		List<ZV_Player__c> newPlayerList = this.createMissingPlayerList(humanPlayerUserIdSet, existingPlayerList);
		existingPlayerList.addAll(newPlayerList);
		PLAYER_LIST = existingPlayerList;
		return new ZV_PlayerCollections(existingPlayerList, newPlayerList); 
	}

	public List<ZV_Player__c> createMissingPlayerList (Set<Id> humanPlayerUserIdSet, List<ZV_Player__c> existingPlayerList) {
		Set<Id> existingHumanPlayerUserIdSet = setHelper.createIdSet(existingPlayerList, ZV_Player__c.User__c);
		Set<Id> missingHumanPlayerUserIdSet = new Set<Id>(); 
		for (Id humanPlayerUserId : humanPlayerUserIdSet) {
			if (!existingHumanPlayerUserIdSet.contains(humanPlayerUserId)) {
				missingHumanPlayerUserIdSet.add(humanPlayerUserId);
			}
		}
		return (missingHumanPlayerUserIdSet != null) ? createMissingPlayerList(missingHumanPlayerUserIdSet) : null;
	}

	public List<ZV_Player__c> createMissingPlayerList (Set<Id> missingHumanPlayerUserIdSet) {
		List<User> userList = this.userSelector.selectById(missingHumanPlayerUserIdSet);
		List<ZV_Player__c> missingPlayerList = new List<ZV_Player__c>();
		for (User user : userList) {
			missingPlayerList.add(new ZV_Player__c(
				User__c = user.id,
				Nickname__c = user.Username
			));
		}
		return missingPlayerList;
	} 
	
    public Id getHumanPlayerId (ZV_Game__c game) {
    	if (HUMAN_PLAYER_BY_USER_ID_MAP == null) { 
    		HUMAN_PLAYER_BY_USER_ID_MAP = this.mapHelper.buidMapBySpecifiedId(PLAYER_LIST, ZV_Player__c.User__c);
    	}
    	return HUMAN_PLAYER_BY_USER_ID_MAP.get(game.OwnerId).id;
    }

    public Id getRobotPlayerId (ZV_Game__c game) {
    	System.debug('######### PLAYER_LIST: ' + PLAYER_LIST);
    	if (ROBOT_PLAYER_BY_STRATEGY_SET_MAP == null) {
    		ROBOT_PLAYER_BY_STRATEGY_SET_MAP = this.mapHelper.buidMappedSetBySpecifiedString(PLAYER_LIST, ZV_Player__c.StrategyClassName__c); 
    	}
    	System.debug('######### ROBOT_PLAYER_BY_STRATEGY_SET_MAP: ' + ROBOT_PLAYER_BY_STRATEGY_SET_MAP);
    	return this.randomizer.getRandomMember(ROBOT_PLAYER_BY_STRATEGY_SET_MAP.get(DEFAULT_ROBOT_STRATEGY)).id;
    }
}