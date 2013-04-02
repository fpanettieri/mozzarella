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
		
		private var m_placeholder:Placeholder;
		
		public function Score(_mastery:Array) 
		{
			m_mastery = _mastery;
			
			m_placeholder = new Placeholder(130, 590, 0xff3c7eb1);
			addChild(m_placeholder);
		}
	}
}