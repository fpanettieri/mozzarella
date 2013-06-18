package com.angrymole.mozzarella.game.score 
{
	import starling.display.Sprite;
	
	/**
	 * Widget used to display the score simple and difuse
	 * @author ...
	 */
	public class SoftScore extends Sprite
	{
		private var LAMP_COUNT:int = 10;
		
		private var m_mastery:Vector.<int> 
		private var m_step:Number;
		private var m_lamps:Vector.<Lamp>;
		
		public function SoftScore(_score:Score) 
		{
			m_mastery = _score.mastery;
			m_step = m_mastery[m_mastery.length - 1] / LAMP_COUNT;
			m_lamps = new Vector.<Lamp>(LAMP_COUNT, true);
			createMasteryLamps();
			createNormalLamps();
			_score.addCallback(updateScore);
		}
		
		private function createMasteryLamps():void
		{
			var lamp:Lamp;
			var idx:int;
			for ( var i:int = 0; i < m_mastery.length; i++ ) {
				idx = Math.floor( m_mastery[i] / m_step );
				if (idx >= LAMP_COUNT) { idx = LAMP_COUNT - 1; }
				lamp = new MasteryLamp(idx, m_step);
				m_lamps[idx] = lamp;
				addChild(lamp);
			}
		}
		
		private function createNormalLamps():void
		{
			var lamp:Lamp;
			var idx:int;
			for ( var i:int = 0; i < m_lamps.length; i++ ) {
				if ( m_lamps[i] != null ) { continue; }
				lamp = new NormalLamp(i, m_step);
				m_lamps[i] = lamp;
				addChild(lamp);
			}
		}
		
		private function updateScore(_score:int):void
		{
			for ( var i:int = 0; i < m_lamps.length; i++ ) {
				m_lamps[i].update(_score);
			}
		}
	}
}