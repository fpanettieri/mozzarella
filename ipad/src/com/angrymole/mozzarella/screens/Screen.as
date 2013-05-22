package com.angrymole.mozzarella.screens
{
	import starling.display.Sprite;
	
	/**
	 * A screen is the base starling object
	 * @author fpanettieri
	 */
	public class Screen extends Sprite
	{
		protected var m_assets:ScreenAssets;
		
		public function get assets():ScreenAssets
		{
			return m_assets;
		}
		
		public function onLoad():void
		{
			throw new Error("Screens must implement this method to instantiate objects and prepare the screen");
		}
	}
}
