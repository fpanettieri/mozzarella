package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.events.TimeTravelEvent;
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
		private var m_button:Placeholder;
		
		// internal state
		private var m_mastery:Vector.<int>;
		private var m_score:Number;
		private var m_maxScore:Number;
		
		// aux vars
		private var m_touch:Touch;
		private var m_tween:Tween;
		
		// temporary
		private var m_text:TextField;
		
		public function Score(_cfg:Configuration) 
		{
			m_mastery =  _cfg.mastery;
			
			m_bg = new Placeholder(130, 450, 0x4D434E);
			addChild(m_bg);
			
			m_bar = new Placeholder(110, 450, 0xD0D0D0);
			m_bar.x = 10;
			m_bar.y = 450;
			m_bar.scaleY = 0;
			addChild(m_bar);
			
			m_button = new Placeholder(130, 130, 0x584B53);
			m_button.y = 460
			addChild(m_button);
			m_button.addEventListener(TouchEvent.TOUCH, onTouch);
			
			m_text = new TextField(130, 30, "0");
			m_text.y = 420;
			addChild(m_text);
			
			m_score = 2500;
			m_maxScore = m_mastery[2] * 1.1;
			
			updateBar();
		}
		
		public function onGroupsBroken(_e:GroupsBrokenEvent):void
		{
			m_score += _e.pieces * 10;
			m_score += _e.groups * 100;
			updateBar();
		}
		
		private function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(m_button);
			if (m_touch == null) { return; }
			
			if (m_touch.phase == TouchPhase.BEGAN) {
				// TODO: switch button state
				
			} else if (m_touch.phase == TouchPhase.ENDED) {
				undoMoves();
			}
		}
		
		private function undoMoves():void
		{
			// TODO: 1000 undo cost, should be configured per level, and increment on consecutive uses
			// if the playe breaks a new group, the cost resets
			
			// TODO: indicate that score is not enough
			if ( m_score < 1000) { return; }
			m_score -= 1000;
			updateBar();
			dispatchEvent( new TimeTravelEvent(TimeTravelEvent.TIME_TRAVEL) );
		}
		
		private function updateBar():void
		{
			var height:int = Math.floor(450 * m_score / m_maxScore);
			var tween:Tween = new Tween(m_bar, 0.3, Transitions.EASE_OUT);
			tween.animate("scaleY", m_score / m_maxScore);
			tween.animate("y", 450 - height);
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
	}
}