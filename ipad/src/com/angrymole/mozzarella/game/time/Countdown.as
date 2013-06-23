package com.angrymole.mozzarella.game.time 
{
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class Countdown extends Timer 
	{
		override public function advanceTime(_time:Number):void 
		{
			if (!m_enabled) { return; }
			m_time -= _time;
			update();
		}		
	}
}