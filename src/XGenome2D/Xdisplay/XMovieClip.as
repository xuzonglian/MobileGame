package XGenome2D.Xdisplay
{
	import com.genome2d.components.renderables.GMovieClip;
	import com.genome2d.core.GNode;
	import com.genome2d.textures.GTextureAtlas;
	
	public class XMovieClip extends GNode
	{
		private var m_gMovieClip:GMovieClip;
		
		public function XMovieClip(p_name:String="")
		{
			super(p_name);
			m_gMovieClip = addComponent(GMovieClip) as GMovieClip;
		}
		
		public function get x():Number 
		{
			return this.transform.x;
		}
		public function set x(p_value:Number):void
		{
			this.transform.x = p_value;
		}
		public function get y():Number 
		{
			return this.transform.y;
		}
		public function set y(p_value:Number):void
		{
			this.transform.y = p_value;
		}
		
		/** 设置纹理 */
		public function setTextureAtlas(p_textureAtlas:GTextureAtlas):void
		{
			m_gMovieClip.setTextureAtlas(p_textureAtlas);
		}
		/** 动画帧 */
		public function set frames(p_frames:Array):void
		{
			m_gMovieClip.frames = p_frames;
		}
		public function get frames():Array
		{
			return m_gMovieClip.frames;
		}
		
		public function set frameRate(p_value:int):void
		{
			m_gMovieClip.frameRate = p_value;
		}
		public function get frameRate():int
		{
			return m_gMovieClip.frameRate;
		}
		/** 总帧数 */
		public function get totalFrameCount():int
		{
			return m_gMovieClip.frames.length;
		}
	}
}