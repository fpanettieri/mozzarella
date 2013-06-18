package com.angrymole.mozzarella.game.score 
{
	import starling.display.Sprite;
	
	/**
	 * Widget used to display the score as plain numbers
	 * @author ...
	 */
	public class HardScore extends Sprite
	{
		private var DIGITS_COUNT:int = 7;

		private var m_score:String;
		private var m_digits:Vector.<ScoreDigit>;
		
		public function HardScore(_score:Score) 
		{
			createDigits();
			_score.addCallback(updateScore);
		}
		
		private function createDigits():void
		{
			m_digits = new Vector.<ScoreDigit>();
			var digit:ScoreDigit;
			for ( var i:int = 0; i < DIGITS_COUNT; i++ ) {
				digit = new ScoreDigit(i);
				addChild(digit);
				m_digits.push(digit);
			}
		}
		
		private function updateScore(_score:int):void
		{
			m_score = String(_score);
			for(var char:int = m_score.length; char < DIGITS_COUNT; char++){
				m_score = '0' + m_score;
			}
			
			for ( var digit:int = 0; digit < m_digits.length; digit++ ) {
				m_digits[digit].update(m_score);
			}
		}
	}
}