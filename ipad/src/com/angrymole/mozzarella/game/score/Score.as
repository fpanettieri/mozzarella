package com.angrymole.mozzarella.game.score 
{
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.game.core.Configuration;
	import com.angrymole.mozzarella.util.Placeholder;
	import starling.animation.IAnimatable;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	/**
	 * Widget used to display the score to the
	 * @author ...
	 */
	public class Score extends Sprite
	{
		private var LAMP_COUNT:int = 10;
		
		private var m_score:Number;
		private var m_mastery:Vector.<int>;
		private var m_step:Number;
		private var m_lamps:Vector.<Lamp>;
		
		private var m_tween:Tween;
		private var m_displayedScore:Number;
		
		public function Score(_cfg:Configuration) 
		{
			m_score = 0;
			m_displayedScore = 0;
			
			m_mastery = _cfg.mastery;
			m_step = m_mastery[m_mastery.length - 1] / LAMP_COUNT;
			m_lamps = new Vector.<Lamp>(LAMP_COUNT, true);
			createMasteryLamps();
			createNormalLamps();
			tweenScore();
		}
		
		public function onGroupsBroken(_e:GroupsBrokenEvent):void
		{
			m_score += _e.pieces * 15 + _e.groups * 80;
			tweenScore();
		}
		
		public function extraScore(_score:Number):void
		{
			m_score += _score;
			tweenScore();
		}
		
		public function reduceScore(_score:Number):void
		{
			m_score -= _score;
			tweenScore();
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
		
		private function tweenScore():void
		{
			var tween:Tween = new Tween(this, 0.3, Transitions.EASE_OUT);
			tween.animate("displayedScore", m_score);
			tween.onUpdate = updateScore;
			queueTween(tween);
		}
		
		private function queueTween(_tween:Tween):void
		{
			if (m_tween == null || m_tween.isComplete) {
				m_tween = _tween;
				Starling.juggler.add(m_tween);
			} else {
				m_tween.nextTween = _tween;
				m_tween = _tween;
			}
		}
		
		private function updateScore():void
		{
			for ( var i:int = 0; i < m_lamps.length; i++ ) {
				m_lamps[i].update(m_displayedScore);
			}
		}
		
		public function get score():Number 
		{
			return m_score;
		}
		
		public function get displayedScore():Number 
		{
			return m_displayedScore;
		}
		
		public function set displayedScore(value:Number):void 
		{
			m_displayedScore = value;
		}
	}
}