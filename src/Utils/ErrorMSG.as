package Utils
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class ErrorMSG
	{
		private static var instance:ErrorMSG;
		
		private var txtArr:Array = [];
		
		public function ErrorMSG()
		{
		}
		
		public static function getInstance():ErrorMSG
		{
			if(instance==null)
			{
				instance = new ErrorMSG();
			}
			return instance;
		}
		
		/** 屏幕中间显示错误信息 */
		public function show(content:String=""):void
		{
			var failed:TextField;
			failed = new TextField();
			failed.selectable = false;
			var dtf:TextFormat = new TextFormat("Arial", 12);
			dtf.align = TextFormatAlign.CENTER;
			dtf.bold = true;
			dtf.color = 0xFF0000;
			
			failed.defaultTextFormat = dtf;
			failed.width = Global.stage.stageWidth;
			failed.height = 30;
			failed.y = (Global.stage.stageHeight-30)/2;
			failed.text = content;
			adjustLocation();
			txtArr.push(failed);
			Global.stage.addChild(failed);
		}
		
		private function adjustLocation():void
		{
			for each(var txt:TextField in txtArr)
			{
				txt.y  -= 30;
			}
		}
	}
}