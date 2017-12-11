public class ZV_UserInfoWrapper {
    @testVisible public Id userId {get; private set;}  
    
    public ZV_UserInfoWrapper() {
    	this.userId = UserInfo.getUserId();
    }
}