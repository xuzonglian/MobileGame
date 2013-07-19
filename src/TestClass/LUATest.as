package TestClass
{
	import luaAlchemy.LuaAlchemy;

	/**
	 * lua相关测试代码
	 * @author xuzonglian
	 */
	public class LUATest
	{
		private static var instance:LUATest;
		
		public function LUATest()
		{
		}
		
		public static function getInstance():LUATest
		{
			if(instance == null){
				instance = new LUATest();
			}
			return instance;
		}
		
		public function test1():void
		{
			var luaString:String = "as3.class.TestClass.TestExcute.getInstance().test1Start()\n print(123)\n as3.trace(124)";
			var lua:LuaAlchemy = new LuaAlchemy();
			lua.setGlobal("this", instance);
			var res:Array = lua.doString(luaString);
			res = lua.doString("return 0,1,2");
//			lua.supplyFile(
		}
		
		public function test1Handler():void
		{
			trace("test1Handler");
			TestExcute.getInstance().test1Start();
//			TestExcute.getInstance().test2Start();
//			TestExcute.getInstance().test3Start();
////			MultiInputTest.getInstance().test1Start();
//			MultiInputTest.getInstance().test2Start();
		}
	}
}