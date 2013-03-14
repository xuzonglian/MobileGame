package
{
	import Utils.ErrorMSG;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MediaEvent;
	import flash.events.MouseEvent;
	import flash.media.Camera;
	import flash.media.CameraRoll;
	import flash.media.CameraUI;
	import flash.media.MediaPromise;
	import flash.media.MediaType;
	import flash.media.Video;
	import flash.utils.getQualifiedClassName;

	public class CameraTest
	{
		private static var instance:CameraTest;
		
		[Embed(source="../assets/test3.png")]
		public static var test3PNG:Class;
		
		public function CameraTest()
		{
		}
		
		public static function getInstance():CameraTest
		{
			if(instance==null)
			{
				instance = new CameraTest();
			}
			return instance;
		}
		
		private var cameraUI:CameraUI;
		private var imageLoader:Loader;
		/** 使用设备上的默认摄像头应用程序捕获静态图像 */
		public function test1():void
		{
			if(!CameraUI.isSupported)
			{
				ErrorMSG.getInstance().show("设备不支持 CameraUI");
				return;
			}
			cameraUI = new CameraUI();
			cameraUI.launch(MediaType.IMAGE);
			cameraUI.addEventListener(MediaEvent.COMPLETE, CameraUIImageCompleteHandler);
			cameraUI.addEventListener(Event.CANCEL, CameraUIImageCancelHandler);
			cameraUI.addEventListener(ErrorEvent.ERROR, CameraUIImageErrorHandler);
		}
		
		private function CameraUIImageCompleteHandler(evt:MediaEvent):void
		{
			var imagePromise:MediaPromise = evt.data;
			imageLoader = new Loader();
			if(imagePromise.isAsync)
			{
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImageHandler);
				imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadImageErrorHandler);
				imageLoader.loadFilePromise(imagePromise);
			}
			else
			{
				imageLoader.loadFilePromise(imagePromise);
				loadImageHandler();
			}
		}
		
		private function loadImageHandler(evt:Event=null):void
		{
			var _bitdata:BitmapData = (imageLoader.content as Bitmap).bitmapData;
			var map:Bitmap = new Bitmap(_bitdata);
			Global.stage.addChild(map);
			map.x = (MobileDeviceInfo.GetInstance().screenSize.width - map.width)/2;
			map.y = (MobileDeviceInfo.GetInstance().screenSize.height - map.height)/2;
			saveToMobile(_bitdata);
		}
		
		/** 将图像添加到设备摄像头卷 */
		public function test3():void
		{
			var bmp:Bitmap = (new test3PNG() as Bitmap);
			Global.stage.addChild(bmp);
			saveToMobile(bmp.bitmapData);
		}
		
		private var cameraRoll:CameraRoll;
		/** 将图像添加到设备摄像头卷 */
		private function saveToMobile(bmpData:BitmapData):void
		{
			if(CameraRoll.supportsAddBitmapData)
			{
				cameraRoll = new CameraRoll();
				cameraRoll.addBitmapData(bmpData);
			}
			else
			{
				ErrorMSG.getInstance().show("设备不支持将图像添加到设备摄像头卷");
			}
		}
		
		private function loadImageErrorHandler(evt:IOErrorEvent):void
		{
			ErrorMSG.getInstance().show("ERROR:"+evt.text);
		}
		
		private function CameraUIImageCancelHandler(evt:Event):void
		{
		}
		private function CameraUIImageErrorHandler(evt:ErrorEvent):void
		{
			ErrorMSG.getInstance().show("ERROR:"+evt.text);
		}
		
		/** 使用设备上的默认摄像头应用程序捕获视频 */
		public function test2():void
		{
			if(!CameraUI.isSupported)
			{
				ErrorMSG.getInstance().show("设备不支持 CameraUI");
				return;
			}
			cameraUI = new CameraUI();
			cameraUI.launch(MediaType.VIDEO);
			cameraUI.addEventListener(MediaEvent.COMPLETE, CameraUIVideoCompleteHandler);
			cameraUI.addEventListener(Event.CANCEL, CameraUIImageCancelHandler);
			cameraUI.addEventListener(ErrorEvent.ERROR, CameraUIImageErrorHandler);
		}
		private function CameraUIVideoCompleteHandler(evt:MediaEvent):void
		{
			var imagePromise:MediaPromise = evt.data;
			imageLoader = new Loader();
			if(imagePromise.isAsync)
			{
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadVideoHandler);
				imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadImageErrorHandler);//loader不支持这个格式。。。。Error #2124: Loaded file is an unknown type
				imageLoader.loadFilePromise(imagePromise);
			}
			else
			{
				imageLoader.loadFilePromise(imagePromise);
				loadVideoHandler();
			}
		}
		private function loadVideoHandler(evt:Event=null):void
		{
			var data:Object = imageLoader.content;
			data.x = (MobileDeviceInfo.GetInstance().screenSize.width - data.width)/2;
			data.y = (MobileDeviceInfo.GetInstance().screenSize.height - data.height)/2;
			Global.stage.addChild(data as DisplayObject);
		}
		
		/** 显示摄像头视频 */
		public function test4():void
		{
			var video:Video = new Video(480, 320);
			var camera:Camera = Camera.getCamera();
			if(Camera.isSupported && camera!=null)
			{
				video.attachCamera(camera);
				Global.stage.addChild(video);
			}
			else
			{
				ErrorMSG.getInstance().show("设备不支持 Camera");
			}
		}
	}
}