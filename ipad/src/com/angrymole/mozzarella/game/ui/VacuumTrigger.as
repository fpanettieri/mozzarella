package com.angrymole.mozzarella.game.ui 
{
	import com.angrymole.mozzarella.events.VacuumEvent;
	import com.angrymole.mozzarella.util.Placeholder;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author ...
	 */
	public class VacuumTrigger extends Sprite 
	{
		private var m_button:Placeholder;
		private var m_touch:Touch;
		
		public function VacuumTrigger() 
		{
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
			dispatchEvent( new VacuumEvent(VacuumEvent.VACUUM_TRIGGER) );
		}
	}
}