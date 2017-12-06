public class ZV_PlayerService {
	ZV_PlayerRepository playerRepository; 
 	
 	public ZV_PlayerService(ZV_PlayerRepository playerRepository) {
 		this.playerRepository = playerRepository; 
 	}
 
 	public ZV_PlayerService() {
 		this(new ZV_PlayerRepository()); 
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
    
}