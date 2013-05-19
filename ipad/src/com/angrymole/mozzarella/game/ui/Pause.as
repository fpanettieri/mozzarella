package com.angrymole.mozzarella.game.ui 
{
	import com.angrymole.mozzarella.util.Placeholder;
	import starling.display.Sprite;
	
	/**
	 * Pause button
	 * @author ...
	 */
	public class Pause extends Sprite 
	{
		private var m_placeholder:Placeholder;
		
		public function Pause() 
		{
			m_placeholder = new Placeholder(130, 44, 0x666666, "pause");
			addChild(m_placeholder);
		}
		
		public function pressed():void
		{
			trace("display pause menu");
		}
	}
}