package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.events.TimeTravelEvent;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Score extends Sprite 
	{
		private var m_bar:Placeholder;
		private var m_button:Placeholder;
		
		// internal state
		private var m_mastery:Vector.<int>;
		private var m_score:Number;
		private var m_maxScore:Number;
		
		// aux vars
		private var m_touch:Touch;
		
		public function Score(_cfg:Configuration) 
		{
			m_mastery =  _cfg.mastery;
			
			m_bar = new Placeholder(130, 450, 0x4D434E);
			addChild(m_bar);
			
			m_button = new Placeholder(130, 130, 0x584B53);
			m_button.y = 460
			addChild(m_button);
			m_button.addEventListener(TouchEvent.TOUCH, onTouch);
			
			m_score = 0;
			m_maxScore = m_mastery[2] * 1.1;
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
			if ( m_score < 100) { return; }
			m_score -= 100;
			updateBar();
			dispatchEvent( new TimeTravelEvent(TimeTravelEvent.TIME_TRAVEL) );
		}
		
		private function updateBar():void
		{
			trace("score", m_score);
		}
	}
}