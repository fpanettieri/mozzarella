package com.angrymole.mozzarella.game.ui 
{
	import com.angrymole.mozzarella.events.PowerupEvent;
	import com.angrymole.mozzarella.util.Placeholder;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author ...
	 */
	public class VaccumTrigger extends Sprite 
	{
		// injected dependency
		private var m_score:Score;
		
		private var m_button:Placeholder;
		private var m_touch:Touch;
		
		public function VaccumTrigger(_score:Score) 
		{
			m_score = _score;
			m_button = new Placeholder(88, 88, 0x584B53, "vacuum");
			addChild(m_button);
			m_button.addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(m_button);
			if (m_touch == null) { return; }
			
			if (m_touch.phase == TouchPhase.BEGAN) {
				m_button.alpha = 0.5;
				// TODO: switch button state
				
			} else if (m_touch.phase == TouchPhase.ENDED) {
				m_button.alpha = 1;
				vacuum();
			}
		}
		
		private function vacuum():void
		{
			// TODO: 1000 undo cost, should be configured per level, and increment on consecutive uses
			// if the playe breaks a new group, the cost resets
			
			// TODO: indicate that score is not enough
			if ( m_score.score < 1000) { return; }
			m_score.extraScore( -1000);
			dispatchEvent( new PowerupEvent(PowerupEvent.VACUUM) );
		}
	}
}