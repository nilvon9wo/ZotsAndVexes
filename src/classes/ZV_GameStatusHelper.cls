public class ZV_GameStatusHelper {
	public static String NEW_GAME = 'New';
	public static String IN_PROGRESS = 'In Progress';
	public static String GAME_WON = 'Won';
	public static String STALEMATE = 'Stalemate';
    
    public Boolean isNew(ZV_Game__c game) {
    	return game.Status__c == NEW_GAME;
    }

    public Boolean isInProgress(ZV_Game__c game) {
    	return game.Status__c == IN_PROGRESS;
    }

    public Boolean isWon(ZV_Game__c game) {
    	return game.Status__c == GAME_WON;
    }

    public Boolean isStalemate(ZV_Game__c game) {
    	return game.Status__c == STALEMATE;
    }
}