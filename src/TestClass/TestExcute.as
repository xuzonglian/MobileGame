package TestClass
{
	import Utils.ErrorMSG;
	
	import com.genome2d.components.renderables.GMovieClip;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.core.GNode;
	import com.genome2d.core.Genome2D;
	import com.genome2d.signals.GMouseSignal;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.textures.factories.GTextureAtlasFactory;
	import com.genome2d.textures.factories.GTextureFactory;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class TestExcute
	{
		[Embed(source="../assets/test/Units.png")]
		public static const asset_Units:Class;
		[Embed(source="../assets/test/Units.xml", mimeType="application/octet-stream")]
		public static const asset_Units_XML:Class;

		private static var instance:TestExcute;
		
		private var gameGNode:GNode;
		
		public function TestExcute()
		{
			gameGNode = Global.game.gameGNode;
		}
		
		public static function getInstance():TestExcute
		{
			if(instance==null)
			{
				instance = new TestExcute();
			}
			return instance;
		}
		
		private var test1Gnode:GNode;
		private var count:int = 0;
		/** (0, 0)位置创建一个50*50的白色方块，点击一次往右下角平移(10, 10) */
		public function test1Start():void
		{
			test1Gnode = new GNode();
			//创建一个白色的50*50的方块
			var texture:GTexture = GTextureFactory.createFromColor("test1", 0xFFFFFF, 500, 500);
			var sp:GSprite = test1Gnode.addComponent(GSprite) as GSprite;
			sp.setTexture(texture);
			gameGNode.addChild(test1Gnode);
			
//			var smc:GMovieClip = test1Gnode.addComponent(GMovieClip) as GMovieClip;
//			smc.setTextureAtlas(
			test1Gnode.mouseEnabled = true;
//			test1Gnode.onMouseClick.add(test1OnMouseClick);
			trace(test1Gnode.transform.x+":"+test1Gnode.transform.y);
			
			Genome2D.getInstance().onPreUpdate.add(test1Update);//每帧刷新执行函数
		}
		private function test1OnMouseClick(signal:GMouseSignal):void
		{
			test1Gnode.transform.x += 10;
			test1Gnode.transform.y += 10;
			trace(test1Gnode.transform.x+":"+test1Gnode.transform.y);
			count = 0;
		}
		private function test1Update(deltaTime:Number):void
		{
			count++;
//			ErrorMSG.getInstance().show(count+"");
//			trace(count+":"+getTimer()+":"+deltaTime);
		}
		
		/** (0, 0)位置创建一个25*25的灰色方块 */
		public function test2Start():void
		{
			var test2Gnode:GNode = new GNode();
			//创建一个白色的25*25的方块
			var texture:GTexture = GTextureFactory.createFromColor("test2", 0xAAAAAA, 25, 25);
			var sp:GSprite = test2Gnode.addComponent(GSprite) as GSprite;
			sp.setTexture(texture);
			gameGNode.addChild(test2Gnode);
		}
		
		/** (0, 0)位置创建一个动画 */
		public function test3Start():void
		{
			var test3GNode:GNode = new GNode();
			var mapdata:BitmapData = (new asset_Units() as Bitmap).bitmapData;
			var configXML:XML = new XML(new asset_Units_XML());
			var textureAtlas:GTextureAtlas = GTextureAtlasFactory.createFromBitmapDataAndXML("Units", mapdata, configXML);
//			test1Gnode.removeComponent(GSprite);
			var gmc:GMovieClip = test3GNode.addComponent(GMovieClip) as GMovieClip;
			gmc.setTextureAtlas(textureAtlas);
			
			var frames:Array = [];
			for(var i:int=8;i<49;)
			{
				var frameName:String = "Rifleman ("+i+")";
				//调节素材的中心点为底部中间
				var tex:GTexture = textureAtlas.getTexture(frameName);
//				tex.pivotX = xx;
				tex.pivotY = tex.height/2;
				frames.push(frameName);
				i += 8;
			}
			gmc.frames = frames;
			gmc.frameRate = 2;
			gameGNode.addChild(test3GNode);
			gmc.play();
		}
	}
}