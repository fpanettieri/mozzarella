package com.angrymole.mozzarella.game.ui 
{
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.util.Placeholder;
	import flash.events.MouseEvent;
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
	public class SpawnTrigger extends Sprite 
	{
		// aux
		private var m_button:Placeholder;
		private var m_touch:Touch;
	
		public function SpawnTrigger() 
		{
			m_button = new Placeholder(128, 128, 0x584B53, "drop");
			addChild(m_button);
			m_button.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// right click drop pieces on pc
			Starling.current.nativeStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, pressTriggger);
			Starling.current.nativeStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, releaseTriggger);
		}
		
		private function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(m_button);
			if (m_touch == null) { return; }
			
			switch(m_touch.phase) {
				case TouchPhase.BEGAN: pressTriggger(); break;
				case TouchPhase.ENDED: releaseTriggger(); break;
			}
		}
		
		private function pressTriggger(_event:MouseEvent = null):void
		{
			m_button.alpha = 0.5;
        }
		
		private function releaseTriggger(_event:MouseEvent = null):void
		{
			dispatchEvent( new SpawnEvent(SpawnEvent.SPAWN_TRIGGER) );
			m_button.alpha = 1;
        }
	}
}