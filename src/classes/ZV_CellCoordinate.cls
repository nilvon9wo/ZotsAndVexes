public class ZV_CellCoordinate {
    public Integer x {get; private set;}
    public Integer y {get; private set;}
    
    public ZV_CellCoordinate(Integer x, Integer y) {
    	this.x = x;
    	this.y = y;
    }
     
    public Boolean equals(Object obj) {
    	ZV_CellCoordinate that = (ZV_CellCoordinate) obj;
    	return this.x == that.x
    		&& this.y == that.y;
    }
}