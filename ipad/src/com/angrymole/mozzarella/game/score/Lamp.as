package com.angrymole.mozzarella.game.score 
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class Lamp extends Sprite
	{
		private var m_idx:Number;
		private var m_min:Number;
		private var m_max:Number;
		
		protected var m_off:Image;
		protected var m_on:Image;
		protected var m_light:Image;
		
		public function Lamp(_idx:int, _step:int)
		{
			m_idx = _idx;
			m_min = _step * _idx;
			m_max = m_min + _step;
		}
		
		public function update(_score:Number):void
		{
			var alpha:Number;
			
			if (_score < m_min) { alpha = 0; }
			else if (_score > m_max) { alpha = 1; }
			else { alpha = (_score - m_min) / m_max ; }
			
			m_on.alpha = alpha;
			m_light.alpha = alpha;
			m_off.alpha = 1 - alpha;
		}
	}

}