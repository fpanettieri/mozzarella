package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.PowerupEvent;
	import com.angrymole.mozzarella.game.Placeholder;
	import com.angrymole.mozzarella.game.Score;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	/**
	 * ...
	 * @author ...
	 */
	public class UndoPowerup extends Sprite 
	{
		// injected dependency
		private var m_score:Score;
		
		private var m_button:Placeholder;
		private var m_touch:Touch;
		
		public function UndoPowerup(_score:Score) 
		{
			m_score = _score;
			m_button = new Placeholder(88, 88, 0x584B53, "undo");
			addChild(m_button);
			m_button.addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(m_button);
			if (m_touch == null) { return; }
			
			if (m_touch.phase == TouchPhase.BEGAN) {
				// TODO: switch button state
				
			} else if (m_touch.phase == TouchPhase.ENDED) {
				undo();
			}
		}
		
		private function undo():void
		{
			// TODO: 1000 undo cost, should be configured per level, and increment on consecutive uses
			// if the playe breaks a new group, the cost resets
			
			// TODO: indicate that score is not enough
			if ( m_score.score < 1000) { return; }
			m_score.extraScore( -1000);
			dispatchEvent( new PowerupEvent(PowerupEvent.UNDO_MOVE) );
		}
	}
}