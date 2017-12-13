public class ZVVC_FullRow implements ZVVC_VictoryConditionIntf {
	public Id checkForWinner(ZV_GameContext gameContext) {
		Id currentGamePlayerId = gameContext.currentGamePlayer.Id;
		ZV_CellCoordinate nextCheckCellCoordinate = new ZV_CellCoordinate(1, 1);

		while (
			gameContext.game.Winner__c == null
			&& nextCheckCellCoordinate.y <= gameContext.board.Height__c
		) {
			ZV_Cell__c cell = gameContext.cellByCellCoordinateMap.get(nextCheckCellCoordinate);
			Boolean playerNotInCell = cell != null && cell.Occupant__c != currentGamePlayerId;  
			if (playerNotInCell) {
				nextCheckCellCoordinate = this.getNextRow(nextCheckCellCoordinate); 
			}
			else {
				if (nextCheckCellCoordinate.x < gameContext.board.Width__c) {
					nextCheckCellCoordinate = this.getNextColumn(nextCheckCellCoordinate);
				}
				else {
					return gameContext.currentPlayer.Id;
				}
			}  
		}
		
		return null; 
	}  

	private ZV_CellCoordinate getNextColumn(ZV_CellCoordinate nextCheckCellCoordinate) {
		return new ZV_CellCoordinate(nextCheckCellCoordinate.x + 1, nextCheckCellCoordinate.y);
	}
	
	private ZV_CellCoordinate getNextRow(ZV_CellCoordinate nextCheckCellCoordinate) {
		return new ZV_CellCoordinate(1, nextCheckCellCoordinate.y + 1);
	}
}