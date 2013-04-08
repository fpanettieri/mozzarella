package com.angrymole.mozzarella.game 
{
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
			m_placeholder = new Placeholder(130, 44, 0x666666);
			addChild(m_placeholder);
			
			// SCORE AND PAUSE BUTTONS ARE NOT ADDED TO THE INTERPRETER
			// AS THEY ARE SIMPLE 3 STATED BUTTONS, and they don't need to handle complex input
			// like tap on empty space nor swipes
		}
		
		public function pressed():void
		{
			trace("display pause menu");
		}
	}
}