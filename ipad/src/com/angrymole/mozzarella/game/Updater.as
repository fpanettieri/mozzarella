package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.interfaces.IUpdatable;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * Can register updatable objects, and update them every frame
	 * 
	 * @author Fabio Panettieri
	 */
	public class Updater extends Sprite
	{
		private var m_updatables:Vector.<IUpdatable>;
		
		public function Updater() 
		{
			m_updatables = new Vector.<IUpdatable>();
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		public function register(_updatable:IUpdatable):void
		{
			m_updatables.push(_updatable);
		}
		
		public function deregister(_updatable:IUpdatable):void
		{
			var pos:int = m_updatables.indexOf(_updatable);
			if (pos < 0) { return; }
			m_updatables.splice(pos, 1);
		}
		
		private function onFrame(_event:EnterFrameEvent):void
		{
			for (var i:int = 0; i < m_updatables.length; i++) {
				m_updatables[i].update(_event.passedTime);
			}
		}
	}
}