package com.angrymole.mozzarella.game.score 
{
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.game.core.Configuration;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	/**
	 * Handle score
	 * @author ...
	 */
	public class Score extends Sprite
	{
		private var m_mastery:Vector.<int>;
		
		private var m_tween:Tween;
		private var m_score:Number;
		private var m_tweenedScore:Number;
		private var m_displayedScore:int;
		
		private var m_callbacks:Vector.<Function>;
		
		public function Score(_cfg:Configuration) 
		{
			m_score = 0;
			m_tweenedScore = 0;
			m_mastery = _cfg.mastery;
			tweenScore();
			m_callbacks = new Vector.<Function>();
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
		
		public function addCallback(_callback:Function):void
		{
			m_callbacks.push(_callback);
		}
		
		public function clearCallbacks():void
		{
			m_callbacks.length = 0;
		}
		
		private function tweenScore():void
		{
			var tween:Tween = new Tween(this, 0.3, Transitions.EASE_OUT);
			tween.animate("tweenedScore", m_score);
			tween.onUpdate = updateScore;
			queueTween(tween);
		}
		
		private function updateScore():void
		{
			m_displayedScore = int(m_tweenedScore);
			for (var i:int = 0; i < m_callbacks.length; i++){
				m_callbacks[i](m_displayedScore);
			}
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
		
		public function get mastery():Vector.<int> 
		{
			return m_mastery;
		}
		
		public function get score():Number 
		{
			return m_score;
		}
		
		public function get tweenedScore():Number 
		{
			return m_tweenedScore;
		}
		
		public function set tweenedScore(value:Number):void 
		{
			m_tweenedScore = value;
		}
	}
}