public class ZV_GameCellContext {
	ZV_BoardSelector boardSelector;
	ZV_CellSelector cellSelector;
	ZV_GameSelector gameSelector;
	ZV_GamePlayerSelector gamePlayerSelector;
	ZV_PlayerSelector playerSelector;
	ZV_UserInfoWrapper userInfoWrapper;

	public ZV_GameCellContext(
			Id cellId,
			ZV_BoardSelector boardSelector,
			ZV_CellSelector cellSelector,
			ZV_GameSelector gameSelector,
			ZV_GamePlayerSelector gamePlayerSelector,
			ZV_PlayerSelector playerSelector,
			ZV_UserInfoWrapper userInfoWrapper
		) {
		this.cellId = cellId;
		this.boardSelector = boardSelector;
		this.cellSelector = cellSelector;
		this.gameSelector = gameSelector;
		this.gamePlayerSelector = gamePlayerSelector;
		this.playerSelector = playerSelector;
		this.userInfoWrapper = userInfoWrapper;
	}		

	public ZV_GameCellContext(Id cellId) {
		this(
			cellId,
			new ZV_BoardSelector(), 
			new ZV_CellSelector(), 
			new ZV_GameSelector(), 
			new ZV_GamePlayerSelector(), 
			new ZV_PlayerSelector(),
			new ZV_UserInfoWrapper()
		);
	}	
	
    @testVisible public ZV_Board__c board {
		get {
			if (this.board == null) {
				this.board = this.boardSelector.selectById(new Set<Id>{this.boardId})[0];
			}
			return this.board;
		} 
		private set;
	} 
    
    @testVisible public Id boardId {
		get {
			if (this.boardId == null) {
				this.boardId = this.cell.Board__c;
			}
			return this.boardId;
		} 
		private set;
	} 
	
    @testVisible public ZV_Cell__c cell {
		get {
			if (this.cell == null) {
				this.cell = this.cellSelector.selectById(new Set<Id>{this.cellId})[0];
			}
			return this.cell;
		} 
		private set;
	} 

    @testVisible public Id cellId {get; private set;}
	
    @testVisible public ZV_Game__c game {
		get {
			if (this.game == null) {
				this.game = this.gameSelector.selectById(new Set<Id>{this.gameId})[0];
			}
			return this.game;
		} 
		private set;
	} 
    
    @testVisible public Id gameId {
		get {
			if (this.gameId == null) {
				this.gameId = board.Game__c;
			}
			return this.gameId;
		} 
		private set;
	} 

    @testVisible public List<ZV_GamePlayer__c> gamePlayerList {
		get {
			if (this.gamePlayerList == null) {
				this.gamePlayerList = this.gamePlayerSelector.selectByGameId(this.gameId);
			}
			return this.gamePlayerList;
		} 
		private set;
	}

    @testVisible public List<ZV_Player__c> playerList {
		get {
			if (this.playerList == null) {
				this.playerList = this.playerSelector.selectFor(this.gamePlayerList);
			}
			return this.playerList;
		} 
		private set;
	}
	
	@testVisible public Id userId {
		get {
			if (this.userId == null) {
				this.userId = this.userInfoWrapper.userId;
			}
			return this.userId;
		} 
		private set;
	} 
}