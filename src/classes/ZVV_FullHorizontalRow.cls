public class ZVV_FullHorizontalRow implements ZVV_VictoryConditionIntf {
	public Id checkForWinner(ZV_GameContext gameContext) {
		Id currentGamePlayerId = gameContext.currentGamePlayer.Id;
		ZV_CellCoordinate nextCheckCellCoordinate = new ZV_CellCoordinate(1, 1);

		while (
			gameContext.game.Winner__c == null
			&& (nextCheckCellCoordinate.x <= gameContext.board.Width__c || nextCheckCellCoordinate.y <= gameContext.board.Height__c)
		) {
			ZV_Cell__c cell = gameContext.cellByCellCoordinateMap.get(nextCheckCellCoordinate);
			if (cell.Occupant__c != currentGamePlayerId) {
				nextCheckCellCoordinate = this.getNextRow(nextCheckCellCoordinate); 
			}
			else {
				if (nextCheckCellCoordinate.x < gameContext.board.Height__c) {
					nextCheckCellCoordinate = this.getNextColumn(nextCheckCellCoordinate);
				}
				else {
					gameContext.game.Winner__c = gameContext.currentPlayer.Id;
				}
			}  
		}
		
		return gameContext.game.Winner__c; 
	}  

	private ZV_CellCoordinate getNextColumn(ZV_CellCoordinate nextCheckCellCoordinate) {
		return new ZV_CellCoordinate(nextCheckCellCoordinate.x + 1, nextCheckCellCoordinate.y);
	}
	
	private ZV_CellCoordinate getNextRow(ZV_CellCoordinate nextCheckCellCoordinate) {
		return new ZV_CellCoordinate(1, nextCheckCellCoordinate.y + 1);
	}
}