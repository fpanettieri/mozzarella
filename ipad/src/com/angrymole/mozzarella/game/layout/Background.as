package com.angrymole.mozzarella.game.layout 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.AtfAsset;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class Background extends Sprite
	{
		private var m_image:Image;
		public function Background() 
		{
			m_image = new Image((Assets.i.getAsset("background") as AtfAsset).texture);
			addChild(m_image);
		}
		
	}

}