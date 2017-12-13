public class ZV_GameContext {
	ZV_BoardSelector boardSelector;
	ZV_CellSelector cellSelector;
	ZV_GameSelector gameSelector;
	ZV_GamePlayerSelector gamePlayerSelector;
	ZV_MapHelper mapHelper;
	ZV_PlayerSelector playerSelector;
	ZV_SetHelper setHelper;
	ZV_UserInfoWrapper userInfoWrapper;

	public ZV_GameContext(
			Id cellId,
			ZV_BoardSelector boardSelector,
			ZV_CellSelector cellSelector,
			ZV_GameSelector gameSelector,
			ZV_GamePlayerSelector gamePlayerSelector,
			ZV_MapHelper mapHelper,
			ZV_PlayerSelector playerSelector,
			ZV_SetHelper setHelper,
			ZV_UserInfoWrapper userInfoWrapper
		) {
		this.cellId = cellId;
		this.boardSelector = boardSelector;
		this.cellSelector = cellSelector; 
		this.gameSelector = gameSelector;
		this.gamePlayerSelector = gamePlayerSelector;
		this.mapHelper = mapHelper;
		this.playerSelector = playerSelector;
		this.setHelper = setHelper;
		this.userInfoWrapper = userInfoWrapper;
	}		

	public ZV_GameContext(Id cellId) {
		this(
			cellId,
			new ZV_BoardSelector(), 
			new ZV_CellSelector(), 
			new ZV_GameSelector(), 
			new ZV_GamePlayerSelector(), 
			new ZV_MapHelper(),
			new ZV_PlayerSelector(),
			new ZV_SetHelper(),
			new ZV_UserInfoWrapper()
		);
	}	
	
    @testVisible public ZV_Board__c board {
		get {
			if (this.board == null) {
				this.board = this.boardSelector.selectWithCells(new Set<Id>{this.boardId})[0];
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

    @testVisible public Map<ZV_CellCoordinate, ZV_Cell__c> cellByCellCoordinateMap {
		get {
			if (this.cellByCellCoordinateMap == null) {
				this.cellByCellCoordinateMap = new Map<ZV_CellCoordinate, ZV_Cell__c>();
				for (ZV_Cell__c cell : this.board.Cells__r) {
					cellByCellCoordinateMap.put(new ZV_CellCoordinate((Integer) cell.X__c, (Integer) cell.Y__c), cell);
				}
			}
			return this.cellByCellCoordinateMap;
		} 
		private set;
	}
    
    public ZV_GamePlayer__c currentGamePlayer;
    
	@testVisible public ZV_Player__c currentPlayer {
		get {
			return this.currentGamePlayer.Player__r;
		}
		private set;		
	}    
    
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
	
    @testVisible public Map<Id, ZV_GamePlayer__c> gamePlayerByIdMap {
		get {
			if (this.gamePlayerByIdMap == null) {
				this.gamePlayerByIdMap = new Map<Id, ZV_GamePlayer__c>(this.gamePlayerList);
			}
			return this.gamePlayerByIdMap;
		} 
		private set;
	}

	// NOTE: This is a map of SObject because of SFDC limitations.
    @testVisible public Map<Decimal, SObject> gamePlayerByOrderMap { 
		get {
			if (this.gamePlayerByOrderMap == null) { 
				this.gamePlayerByOrderMap 
					= this.mapHelper.buidMapBySpecifiedDecimal(this.gamePlayerList, ZV_GamePlayer__c.PlayOrder__c);
			}
			return this.gamePlayerByOrderMap;
		} 
		private set;
	}
	
    @testVisible public Map<Id, ZV_GamePlayer__c> gamePlayerByPlayerIdMap {
		get {
			if (this.gamePlayerByPlayerIdMap == null) {
				this.gamePlayerByPlayerIdMap 
					= (Map<Id, ZV_GamePlayer__c>) this.mapHelper.buidMapBySpecifiedId(this.gamePlayerList, ZV_GamePlayer__c.Player__c);
			}
			return this.gamePlayerByPlayerIdMap;
		} 
		private set;
	}
	
    @testVisible public Map<Id, ZV_GamePlayer__c> gamePlayerByUserIdMap {
		get {
			if (this.gamePlayerByUserIdMap == null) {
				gamePlayerByUserIdMap = new Map<Id, ZV_GamePlayer__c>();
				for (ZV_GamePlayer__c gamePlayer : this.gamePlayerList) {
					Id userId = this.playerByIdMap.get(gamePlayer.Player__c).User__c;
					this.gamePlayerByUserIdMap.put(userId, gamePlayer);
				}
			}
			return this.gamePlayerByUserIdMap;
		} 
		private set;
	} 
	
	@testVisible public Id nextGamePlayerId {
		get {
			this.nextGamePlayerId = this.game.NextPlayer__c;
			if (this.nextGamePlayerId == null) {
				this.nextGamePlayerId = this.gamePlayerList[0].Id;
			}
			return this.nextGamePlayerId;
		}
		private set;		
	}

	@testVisible public ZV_GamePlayer__c nextGamePlayer {
		get {
			return this.gamePlayerByIdMap.get(this.nextGamePlayerId);
		}
		private set;		
	}

	@testVisible public ZV_Player__c nextPlayer {
		get {
			return this.nextGamePlayer.Player__r;
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

    @testVisible public Map<Id, ZV_Player__c> playerByGamePlayerIdMap {
		get {
			if (this.playerByGamePlayerIdMap == null) {
				this.playerByGamePlayerIdMap = new Map<Id, ZV_Player__c>();
				for(ZV_GamePlayer__c gamePlayer : this.gamePlayerList) {
					playerByGamePlayerIdMap.put(gamePlayer.Id, gamePlayer.Player__r);
				}
			}
			return this.playerByGamePlayerIdMap;
		} 
		private set;
	}

    @testVisible public Map<Id, ZV_Player__c> playerByIdMap {
		get {
			if (this.playerByIdMap == null) {
				this.playerByIdMap = new Map<Id, ZV_Player__c>(this.playerList);
			}
			return this.playerByIdMap;
		} 
		private set;
	}

	// NOTE: This is a map of SObject because of SFDC limitations.
    @testVisible public Map<Id, SObject> playerByUserIdMap {
		get {
			if (this.playerByUserIdMap == null) {
				this.playerByUserIdMap 
					= this.mapHelper.buidMapBySpecifiedId(this.playerList, ZV_Player__c.User__c);
			}
			return this.playerByUserIdMap;
		} 
		private set;
	}
	
	@testVisible public Set<Id> playerUserIdSet {
		get {
			if (this.playerUserIdSet == null) {
				this.playerUserIdSet = this.setHelper.createIdSet(this.playerList, ZV_Player__c.User__c);
			}
			return this.playerUserIdSet;
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

	@testVisible public String userName {   
		get {
			if (this.userName == null) {
				this.userName = this.userInfoWrapper.userName;
			}
			return this.userName; 
		} 
		private set;
	}

	@testVisible public String userNickName {   
		get {
			if (this.userNickName == null) {
				this.userNickName = ((ZV_Player__c) this.playerByUserIdMap.get(this.userId)).NickName__c;
			}
			return this.userNickName; 
		} 
		private set;
	}
	
	@testVisible public Set<ZV_Cell__c> unoccupiedCellSet {
		get {
			Map<Id, ZV_Cell__c> updatedCellByIdMap = new Map<Id, ZV_Cell__c>(this.updatedCellList);
			
			Set<ZV_Cell__c> unoccupiedCellSet = new Set<ZV_Cell__c>();
			for (ZV_Cell__c cell : this.board.Cells__r) {
				if (
						cell.Occupant__c == null
						&& (updatedCellByIdMap.get(cell.Id) == null || updatedCellByIdMap.get(cell.Id).Occupant__c == null)
					) {
					unoccupiedCellSet.add(cell);
				}
			}
			return unoccupiedCellSet;
		}
		private set;
	}
	
	public List<ZV_Cell__c> updatedCellList;
}