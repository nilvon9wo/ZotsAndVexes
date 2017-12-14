public class ZVVC_FullColumn implements ZVVC_VictoryConditionIntf {
	public Id checkForWinner(ZV_GameContext gameContext) {
		Id currentGamePlayerId = gameContext.currentGamePlayer.Id;
		ZV_CellCoordinate nextCheckCellCoordinate = new ZV_CellCoordinate(1, 1);

		while (
			gameContext.game.Winner__c == null
			&& nextCheckCellCoordinate.x <= gameContext.board.Width__c 
		) {
			ZV_Cell__c cell = gameContext.cellByCellCoordinateMap.get(nextCheckCellCoordinate);

			if (cell != null) {
				Boolean playerNotInCell = cell.Occupant__c != currentGamePlayerId;  
				if (playerNotInCell) {
					nextCheckCellCoordinate = this.getNextColumn(nextCheckCellCoordinate);
				}
				else {
					if (nextCheckCellCoordinate.y <= gameContext.board.Height__c) {
						nextCheckCellCoordinate = this.getNextRow(nextCheckCellCoordinate); 
					}
					else if (nextCheckCellCoordinate.y == gameContext.board.Height__c){
						return currentGamePlayerId;
					}
				}  
			} 
		}
		
		return null; 
	} 

	private ZV_CellCoordinate getNextColumn(ZV_CellCoordinate nextCheckCellCoordinate) {
		return new ZV_CellCoordinate(nextCheckCellCoordinate.x + 1, 1);
	}
	
	private ZV_CellCoordinate getNextRow(ZV_CellCoordinate nextCheckCellCoordinate) {
		return new ZV_CellCoordinate(nextCheckCellCoordinate.x, nextCheckCellCoordinate.y + 1);
	}
}