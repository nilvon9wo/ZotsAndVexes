public interface ZVG_GameIntf {
    List<ZV_GamePlayer__c> attachPlayers (List<ZV_Game__C> gameList);
    Boolean canOccupyCell(ZV_GameCellContext gameCellContext);
}