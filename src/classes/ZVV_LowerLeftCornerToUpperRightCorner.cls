public class ZVV_LowerLeftCornerToUpperRightCorner implements ZVV_VictoryConditionIntf {
	public Id checkForWinner(ZV_GameContext gameContext) {
		Id currentGamePlayerId = gameContext.currentGamePlayer.Id;
		ZV_CellCoordinate nextCheckCellCoordinate = new ZV_CellCoordinate(1, (Integer) gameContext.board.Height__c);
		
		Boolean isVictoryPossible = true;
		while (
			isVictoryPossible
			&& gameContext.game.Winner__c == null
			&& (nextCheckCellCoordinate.x <= gameContext.board.Width__c || nextCheckCellCoordinate.y > 0)
		) {
			
			ZV_Cell__c cell = gameContext.cellByCellCoordinateMap.get(nextCheckCellCoordinate);
			Boolean playerInCell = cell != null && cell.Occupant__c == currentGamePlayerId;  
			if (playerInCell) {
				nextCheckCellCoordinate = this.getNextCell(nextCheckCellCoordinate);
				if (nextCheckCellCoordinate.x > gameContext.board.Width__c) {
					return gameContext.currentPlayer.Id;
				}
			}
			else {
				isVictoryPossible = false;
			}
		}
		
		return null; 
	} 

	private ZV_CellCoordinate getNextCell(ZV_CellCoordinate nextCheckCellCoordinate) {
		return new ZV_CellCoordinate(nextCheckCellCoordinate.x + 1, nextCheckCellCoordinate.y - 1);
	}
}