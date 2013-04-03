package TestClass
{
	import Utils.ErrorMSG;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;

	/**
	 * 多点触控相关的测试
	 * @author xuzonglian
	 */
	public class MultiInputTest
	{
		private static var instance:MultiInputTest;

		public function MultiInputTest()
		{
			
		}
		
		public static function getInstance():MultiInputTest
		{
			if(instance==null)
			{
				instance = new MultiInputTest();
			}
			return instance;
		}
		
		/** 
		 * GestureEvent多点操作
		 * */
		public function test1Start():void
		{
			var g:Vector.<String> = Multitouch.supportedGestures;
			if(g == null)
			{
				g = new Vector.<String>();
				g.push("none");
			}
			trace(g);
			ErrorMSG.getInstance().show(g.toString());
			
			Global.stage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, swipeHandler);
			Global.stage.addEventListener(TransformGestureEvent.GESTURE_PAN, panHandler);
		}
		
		private function swipeHandler(evt:TransformGestureEvent):void
		{
			ErrorMSG.getInstance().show("GESTURE_SWIPE");
		}
		
		private function panHandler(evt:TransformGestureEvent):void
		{
			ErrorMSG.getInstance().show("GESTURE_PAN");
		}
		
		/** TouchEvent测试 */
		public function test2Start():void
		{
//			var filBit:Bitmap = new Bitmap(new BitmapData(MobileDeviceInfo.GetInstance().screenSize.width, MobileDeviceInfo.GetInstance().screenSize.height));
			var sp:Sprite = new Sprite();
//			sp.addChild(filBit);
//			sp.alpha = 0.5;
			sp.graphics.beginFill(0x336699); 
			sp.graphics.drawRect(0,0,400,400); 
			Global.stage.addChild(sp);
			
			Global.stage.addEventListener(TouchEvent.TOUCH_BEGIN, touchBeginHandler);
			Global.stage.addEventListener(TouchEvent.TOUCH_MOVE, touchMoveHandler);
			Global.stage.addEventListener(TouchEvent.TOUCH_END, touchEndHandler);
//			sp.addEventListener(TouchEvent.TOUCH_BEGIN, touchBeginHandler, true);
//			sp.addEventListener(TouchEvent.TOUCH_MOVE, touchMoveHandler, true);
//			sp.addEventListener(TouchEvent.TOUCH_END, touchEndHandler, true);
		}
		private var fingerCount:Object = {};
		private function touchBeginHandler(evt:TouchEvent):void
		{
			fingerCount[evt.touchPointID] = 0;
//			ErrorMSG.getInstance().show("TouchBegin:"+evt.touchPointID+":"+fingerCount[evt.touchPointID]+"("+evt.stageX+","+ evt.stageY+")");
			ErrorMSG.getInstance().show("TouchBegin:"+evt.touchPointID);
			setFinger(evt.touchPointID, evt.stageX, evt.stageY);
		}
		private function touchMoveHandler(evt:TouchEvent):void
		{
			fingerCount[evt.touchPointID] = int(fingerCount[evt.touchPointID]) + 1;
//			ErrorMSG.getInstance().show("TouchMove:"+evt.touchPointID+":"+fingerCount[evt.touchPointID]+"("+evt.stageX+","+ evt.stageY+")");
			setFinger(evt.touchPointID, evt.stageX, evt.stageY);
		}
		private function touchEndHandler(evt:TouchEvent):void
		{
			ErrorMSG.getInstance().show("TouchEnd:"+evt.touchPointID);
			clearFinger(evt.touchPointID);
		}
		
		private var finger1:int = -1;
		private var finger2:int = -1;
		private var hasFinger1:Boolean = false;
		private var hasFinger2:Boolean = false;
		private var location1:Point = new Point();
		private var location2:Point = new Point();
		private var x1:Number;
		private var x2:Number;
		private var y1:Number;
		private var y2:Number;
		private var rectSprite:Sprite = null;
		private function setFinger(pointID:int, xx:Number, yy:Number):void
		{
			var needUpdateRect:Boolean = false;
			if(hasFinger1 && finger1 == pointID)
			{
				if(location1.x - xx > 5 || location1.x - xx < -5 || location1.y - yy > 5 || location1.y - yy < -5)
				{
					needUpdateRect = true;
					finger1 = pointID;
					location1.x = xx;
					location1.y = yy;
				}
			}
			else if(hasFinger2 && finger2 == pointID)
			{
				if(location2.x - xx > 5 || location2.x - xx < -5 || location2.y - yy > 5 || location2.y - yy < -5)
				{
					needUpdateRect = true;
					finger2 = pointID;
					location2.x = xx;
					location2.y = yy;
				}
			}
			else if(hasFinger1==false)
			{
				hasFinger1 = true;
				needUpdateRect = true;
				finger1 = pointID;
				location1.x = xx;
				location1.y = yy;
			}
			else if(hasFinger2 == false)
			{
				hasFinger2 = true;
				needUpdateRect = true;
				finger2 = pointID;
				location2.x = xx;
				location2.y = yy;
			}
			else{
				return;
			}
			if(needUpdateRect)
			{
				updateRect();
			}
		}
		private function clearFinger(pointID:int):void
		{
			if(hasFinger1 && finger1 == pointID){
				hasFinger1 = false;
				finger1 = -1;
				updateRect();
			}
			if(hasFinger2 && finger2 == pointID){
				hasFinger2 = false;
				finger2 = -1;
				updateRect();
			}
		}
		private var updateCount:int = 0;
		private function updateRect():void
		{
			if(hasFinger1 && hasFinger2)
			{
				updateCount ++;
				ErrorMSG.getInstance().show("updateCount:"+updateCount);
				if(location1.x < location2.x){
					x1 = location1.x;
					x2 = location2.x;
				}
				else{
					x1 = location2.x;
					x2 = location1.x;
				}
				if(location1.y < location2.y){
					y1 = location1.y;
					y2 = location2.y;
				}
				else{
					y1 = location2.y;
					y2 = location1.y;
				}
				if(rectSprite == null)
				{
					rectSprite = new Sprite();
					Global.stage.addChild(rectSprite);
				}
				var graph:Graphics = rectSprite.graphics;
				graph.clear();
				graph.lineStyle(1, 0x00FF00);
				graph.moveTo(x1, y1);
				graph.lineTo(x1, y2);
				graph.lineTo(x2, y2);
				graph.lineTo(x2, y1);
				graph.lineTo(x1, y1);
			}
			else{
				updateCount = 0;
				if(rectSprite)
				{
					rectSprite.graphics.clear();
				}
			}
		}
	}
}