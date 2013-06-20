package com.angrymole.mozzarella.game.ui 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.DragonbonesAsset;
	import com.angrymole.dragonbones.StarlingArmature;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.util.Placeholder;
	import dragonBones.Armature;
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
		private var m_ready:Boolean;
		private var m_input:Placeholder
		
		private var m_asset:DragonbonesAsset;
		private var m_armature:StarlingArmature;
		private var m_touch:Touch;
	
		public function SpawnTrigger() 
		{
			m_ready = false;
			
			m_input = new Placeholder(200, 270, 0);
			m_input.alpha = 0;
			m_input.x = 40;
			m_input.y = -130;
			m_input.addEventListener(TouchEvent.TOUCH, onTouch);
			
			m_asset = Assets.i.getAsset("layout") as DragonbonesAsset;
			m_armature = m_asset.getArmature("lever");
			Starling.juggler.add(m_armature);
			
			m_armature.display.x = 160;
			m_armature.display.y = 50;
			
			addChild(m_armature.display);
			addChild(m_input);
			
			// right click drop pieces on pc
			Starling.current.nativeStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, pressTriggger);
			Starling.current.nativeStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, releaseTriggger);
		}
		
		public function onSpawnSwappable(_event:SpawnEvent):void
		{
			m_ready = true;
		}
		
		public function onSpawnLocked(_event:SpawnEvent):void
		{
			m_ready = false;
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
		
		private function pressTriggger(_event:MouseEvent = null):void
		{
			if (!m_ready) { return; }
			m_ready = false;
			m_armature.animation.gotoAndPlay("pull");
        }
		
		private function releaseTriggger(_event:MouseEvent = null):void
		{
			dispatchEvent( new SpawnEvent(SpawnEvent.SPAWN_TRIGGER) );
        }
	}
}