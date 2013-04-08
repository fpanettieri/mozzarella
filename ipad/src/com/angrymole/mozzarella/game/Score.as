package com.angrymole.mozzarella.game 
{
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Score extends Sprite 
	{
		private var m_mastery:Array;
		
		private var m_bar:Placeholder;
		private var m_button:Placeholder;
		
		public function Score(_mastery:Array) 
		{
			m_mastery = _mastery;
			
			m_bar = new Placeholder(130, 450, 0x919C86);
			addChild(m_bar);
			
			m_button = new Placeholder(130, 130, 0x666666);
			m_button.y = 460
			addChild(m_button);
			
			// FIXME: IMPLEMENT ALL THIS!
			
			// SCORE AND PAUSE BUTTONS ARE NOT ADDED TO THE INTERPRETER
			// AS THEY ARE SIMPLE 3 STATED BUTTONS, and they don't need to handle complex input
			// like tap on empty space nor swipes
		}
	}
}