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
	public class DropTrigger extends Sprite 
	{
		// injected dependency
		private var m_spawner:Spawner;
		
		// aux
		private var m_button:Placeholder;
		private var m_touch:Touch;
		private var m_remainingText:TextField;
		
		// internal state
		private var m_active:Boolean;
		private var m_remaining:int;
		
		public function DropTrigger(_spawner:Spawner) 
		{
			m_active = false;
			m_spawner = _spawner;
			
			m_button = new Placeholder(128, 128, 0x584B53, "drop");
			addChild(m_button);
			m_button.addEventListener(TouchEvent.TOUCH, onTouch);
			
			m_remainingText = new TextField(30, 30, "", "Verdana", 24);
			m_remainingText.x = 90;
			addChild(m_remainingText);
			
			// right click drop pieces on pc
			Starling.current.nativeStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, pressTriggger);
			Starling.current.nativeStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, releaseTriggger);
		}
		
		public function onSpawnStarted(_e:SpawnEvent):void
		{
			// TODO: reset the animation
		}
		
		public function onSpawnSwappable(_e:SpawnEvent):void
		{
			m_active = true;
			m_remaining = m_spawner.spawnLife;
			updateRemainingTime();
		}
		
		public function onSpawnLocked(_e:SpawnEvent):void
		{
			m_active = false;
			// TODO: pull the lever animation
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
			m_button.alpha = 1;
			m_active = false;
			m_remaining = 0;
			m_spawner.lockPieces();
        }
		
		private function updateRemainingTime():void
		{
			// FIXME: remove hard coded value
			if ( m_remaining < 5 && m_remaining > 0) {
				m_remainingText.text = m_remaining.toString();
			
			} else {
				m_remainingText.text = "";
			}
			
			m_remaining--;
			if (!m_active) { return; }
			Starling.juggler.delayCall(updateRemainingTime, 1);
		}
	}
}