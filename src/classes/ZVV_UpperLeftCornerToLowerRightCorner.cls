public class ZVV_UpperLeftCornerToLowerRightCorner implements ZVV_VictoryConditionIntf {
	public Id declareWinner(ZV_GameContext gameContext) {
		Id currentGamePlayerId = gameContext.currentGamePlayer.Id;
		ZV_CellCoordinate nextCheckCellCoordinate = new ZV_CellCoordinate(1, 1);
		while (
			gameContext.game.Winner__c == null
			&& nextCheckCellCoordinate.x <= gameContext.board.Width__c
			&& nextCheckCellCoordinate.y <= gameContext.board.Height__c
		) {
			
			ZV_Cell__c cell = gameContext.cellByCellCoordinateMap.get(nextCheckCellCoordinate);
			if (cell.Occupant__c == currentGamePlayerId) {
				nextCheckCellCoordinate = this.getNextCell(nextCheckCellCoordinate);
				if (nextCheckCellCoordinate.x > gameContext.board.Width__c) {
					gameContext.game.Winner__c = currentGamePlayerId;
				}
			}
		}
		
		return gameContext.game.Winner__c; 
	} 

	private ZV_CellCoordinate getNextCell(ZV_CellCoordinate nextCheckCellCoordinate) {
		return new ZV_CellCoordinate(nextCheckCellCoordinate.x++, nextCheckCellCoordinate.y++);
	}
}