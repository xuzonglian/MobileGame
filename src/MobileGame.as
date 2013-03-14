package
{
	import Utils.ErrorMSG;
	
	import com.genome2d.components.GCamera;
	import com.genome2d.core.GConfig;
	import com.genome2d.core.GNode;
	import com.genome2d.core.Genome2D;
	import com.genome2d.textures.GTextureBase;
	import com.genome2d.textures.GTextureFilteringType;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	[SWF(frameRate="60")]
	public class MobileGame extends Sprite
	{
		public var gameGNode:GNode;
		
		public function MobileGame()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			setGlobalData();
			initGenome();
		}
		
		private function setGlobalData():void
		{
			Global.stage = stage;
			Global.game = this;
			var fw:int=Math.max(stage.fullScreenWidth, stage.fullScreenHeight);
			var fh:int=Math.min(stage.fullScreenWidth, stage.fullScreenHeight);
			MobileDeviceInfo.GetInstance().screenSize = new Rectangle(0, 0, fw, fh);
			MobileDeviceInfo.GetInstance().centerPoint = new Point(Number(fw/2), Number(fh/2));
		}
		
		private function initGenome():void
		{
			//设置默认纹理过滤
			GTextureBase.defaultFilteringType = GTextureFilteringType.NEAREST;
			Genome2D.getInstance().autoUpdate = true;
			//注册G2D初始化事件
			Genome2D.getInstance().onInitialized.addOnce(onGenomeInitialized);
			//注册G2D失败事件
			Genome2D.getInstance().onFailed.addOnce(onGenomeFailed);
			
			//G2D上下文配置
			var config:GConfig = new GConfig(MobileDeviceInfo.GetInstance().screenSize);						
			config.enableStats = true;//显示应用运行状态
			config.antiAliasing = 0;//抗锯齿
			config.useSeparatedAlphaShaders = true;
			Genome2D.getInstance().init(stage, config);//初始化G2D
			//多点支持模式
//			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}
		
		private function onGenomeInitialized():void
		{
			gameGNode = new GNode();
			Genome2D.getInstance().root.addChild(gameGNode);
			registerGenomeCamera();
			startGame();
		}
		/** 注册摄像机 */
		private function registerGenomeCamera():void
		{
			var cameraGNode:GNode = new GNode();
			var camera:GCamera = gameGNode.addComponent(GCamera) as GCamera;
			Genome2D.getInstance().root.addChild(cameraGNode);
			cameraGNode.transform.x = MobileDeviceInfo.GetInstance().centerPoint.x;
			cameraGNode.transform.y = MobileDeviceInfo.GetInstance().centerPoint.y;
			camera.mask = 1;
			gameGNode.cameraGroup = 1;
		}
		
		private function onGenomeFailed():void
		{
			ErrorMSG.getInstance().show("Genome2D initialization failed device doesn't support Stage3D renderer.");
		}
		
		/** 初始化完成，开始Game */
		private function startGame():void
		{
			CameraTest.getInstance().test4();
		}
	}
}