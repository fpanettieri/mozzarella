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
	public class DropTrigger extends Sprite 
	{
		// injected dependency
		private var m_spawner:Spawner;
		
		private var m_button:Placeholder;
		private var m_touch:Touch;
		
		public function DropTrigger(_spawner:Spawner) 
		{
			m_spawner = _spawner;
			m_button = new Placeholder(128, 128, 0x584B53, "drop");
			addChild(m_button);
			m_button.addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(m_button, TouchPhase.BEGAN);
			if (m_touch == null) { return; }
			
			m_spawner.lockPieces();
		}
	}
}