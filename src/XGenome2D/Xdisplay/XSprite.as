package XGenome2D.Xdisplay
{
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.core.GNode;
	import com.genome2d.textures.GTexture;
	
	public class XSprite extends GNode
	{
		private var m_gSprite:GSprite;
		
		public function XSprite(p_name:String="")
		{
			super(p_name);
			m_gSprite = this.addComponent(GSprite) as GSprite;
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
		public function setTexture(p_texture:GTexture):void
		{
			this.m_gSprite.setTexture(p_texture);
		}
	}
}