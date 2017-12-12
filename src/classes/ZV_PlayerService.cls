public class ZV_PlayerService {
	ZV_PlayerRepository playerRepository; 
	ZV_PlayerTypeEnumHelper playerTypeEnumHelper;
 	
 	public ZV_PlayerService(ZV_PlayerRepository playerRepository, ZV_PlayerTypeEnumHelper playerTypeEnum) {
 		this.playerRepository = playerRepository; 
 		this.playerTypeEnumHelper = playerTypeEnumHelper; 
 	}
 
 	public ZV_PlayerService() {
 		this(new ZV_PlayerRepository(), new ZV_PlayerTypeEnumHelper()); 
 	}
 
	public ZV_PlayerCollections loadPlayers (List<ZV_Game__c> gameList) {
		return this.playerRepository.loadPlayers(gameList);
	} 

    public Id getHumanPlayerId (ZV_Game__c game) {
    	return this.playerRepository.getHumanPlayerId(game);  
    }

    public Id getRobotPlayerId (ZV_Game__c game) {
    	return this.playerRepository.getRobotPlayerId(game);  
    }
    
    public Boolean isRobot(ZV_Player__c player) {
    	return this.playerTypeEnumHelper.convertToEnumFor(player) == ZV_PlayerTypeEnum.ROBOT;
    }
}