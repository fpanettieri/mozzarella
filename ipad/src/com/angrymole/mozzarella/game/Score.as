package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Score extends Sprite 
	{
		private var m_bg:Placeholder;
		private var m_bar:Placeholder;
		private var m_masteryBars:Vector.<Placeholder>;
		
		// internal state
		private var m_mastery:Vector.<int>;
		private var m_score:Number;
		private var m_maxScore:Number;
		
		// aux vars
		private var m_tween:Tween;
		
		// FIXME: REMOVE THIS, DEBUG ONLY
		private var m_text:TextField;
		
		public function Score(_cfg:Configuration) 
		{
			m_mastery =  _cfg.mastery;
			
			m_bg = new Placeholder(64, 584, 0x4D434E);
			addChild(m_bg);
			
			m_bar = new Placeholder(48, 584, 0xD0D0D0);
			m_bar.x = 8;
			m_bar.y = 584;
			m_bar.scaleY = 0;
			addChild(m_bar);
			
			m_text = new TextField(64, 30, "0");
			m_text.y = 540;
			addChild(m_text);
			
			m_score = 0;
			m_maxScore = m_mastery[2] * 1.1;
			
			m_masteryBars = new Vector.<Placeholder>();
			var bar:Placeholder;
			for (var i:int = 0; i < m_mastery.length; i++) {
				bar = new Placeholder(64, 2, 0x303030);
				bar.y = m_mastery[i] / m_maxScore * 584;
				m_masteryBars.push(bar);
				addChild(bar);
			}
			
			update();
		}
		
		public function onGroupsBroken(_e:GroupsBrokenEvent):void
		{
			m_score += _e.pieces * 10;
			m_score += _e.groups * 100;
			update();
		}
		
		public function extraScore(_score:Number):void
		{
			m_score += _score;
			update();
		}
		
		private function update():void
		{
			var height:int = Math.floor(584 * m_score / m_maxScore);
			var tween:Tween = new Tween(m_bar, 0.3, Transitions.EASE_OUT);
			tween.animate("scaleY", m_score / m_maxScore);
			tween.animate("y", 584 - height);
			queueTween(tween);
			
			m_text.text = m_score.toString();
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
		
		public function get score():Number 
		{
			return m_score;
		}
	}
}