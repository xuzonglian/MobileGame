package
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 移动设备信息
	 * @author xuzonglian
	 */
	public class MobileDeviceInfo
	{
		private static var instance:MobileDeviceInfo=null;
		
		public var screenSize:Rectangle=null;
		/** 屏幕中心点 */
		public var centerPoint:Point=null;
		
		public function MobileDeviceInfo()
		{
			initDeviceInfo();
		}
		
		public static function GetInstance():MobileDeviceInfo
		{
			if(instance==null){
				instance = new MobileDeviceInfo();
			}
			return instance;
		}
		
		/** 初始化设备信息 */
		private function initDeviceInfo():void
		{
			
		}
	}
}