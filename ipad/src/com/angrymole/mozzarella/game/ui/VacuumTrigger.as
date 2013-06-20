package com.angrymole.mozzarella.game.ui 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.DragonbonesAsset;
	import com.angrymole.dragonbones.StarlingArmature;
	import com.angrymole.mozzarella.events.VacuumEvent;
	import com.angrymole.mozzarella.util.MathUtil;
	import com.angrymole.mozzarella.util.Placeholder;
	import flash.events.MouseEvent;
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
		private var m_ready:Boolean;
		private var m_input:Placeholder;
		
		private var m_asset:DragonbonesAsset;
		private var m_armature:StarlingArmature;
		private var m_touch:Touch;
		
		public function VacuumTrigger() 
		{
			m_ready = false;
			
			m_input  = new Placeholder(90, 160, 0x584B53, "vacuum");
			m_input.alpha = 0;
			m_input.x = 0;
			m_input.y = 0;
			m_input.addEventListener(TouchEvent.TOUCH, onTouch);
			
			m_asset = Assets.i.getAsset("layout") as DragonbonesAsset;
			m_armature = m_asset.getArmature("powerup_btn");
			m_armature.display.scaleX = 0.3;
			m_armature.display.scaleY = 1;
			
			m_armature.display.x = 45;
			m_armature.display.y = 80;
			m_armature.display.skewY = 0.1;			
			
			addChild(m_armature.display);
			addChild(m_input);
		}

		private function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(m_input);
			if (m_touch == null) { return; }
			
			switch(m_touch.phase) {
				case TouchPhase.BEGAN: pressTriggger(); break;
				case TouchPhase.ENDED: releaseTriggger(); break;
			}
		}
		
		private function pressTriggger():void
		{
			if (!m_ready) { return; }
			m_ready = false;
        }
		
		private function releaseTriggger(_event:MouseEvent = null):void
		{
			dispatchEvent( new VacuumEvent(VacuumEvent.VACUUM_TRIGGER) );
        }
	}
}