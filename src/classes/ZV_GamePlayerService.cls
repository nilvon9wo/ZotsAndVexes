public class ZV_GamePlayerService {
	ZV_TraditionalTicTacToeGameVsComputer traditionalTicTacToeGameVsComputer;
	
	public ZV_GamePlayerService(ZV_TraditionalTicTacToeGameVsComputer traditionalTicTacToeGameVsComputer) {
		this.traditionalTicTacToeGameVsComputer = traditionalTicTacToeGameVsComputer;
	}

	public ZV_GamePlayerService() {
		this(new ZV_TraditionalTicTacToeGameVsComputer());
	}
	
    public List<ZV_GamePlayer__c> attachPlayers (List<ZV_Game__C> gameList) {
    	return traditionalTicTacToeGameVsComputer.attachPlayers(gameList);
    }
}