package com.angrymole.mozzarella.screens.loading 
{
	import com.angrymole.dragonbones.StarlingArmature;
	import com.angrymole.mozzarella.screens.Screen;
	import dragonBones.animation.WorldClock;
	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	/**
	 * Loading screen, the only screen using embeded assets
	 * It displays a small cicle on the bottom right corner
	 * 
	 * @author Fabio Panettieri
	 */
	public class Loading extends Screen
	{
		[Embed(source="Loading.png", mimeType="application/octet-stream")]
		private static const LoadingResources:Class;
		
		private var m_factory:StarlingFactory;
		private var m_armature:StarlingArmature;
		private var m_sprite:Sprite;
		
		private var m_progress:Number;
		
		// TODO: add a resources 
		
		public function Loading() 
		{
			m_factory = new StarlingFactory();
			m_factory.addEventListener(Event.COMPLETE, onDataParsed);
            m_factory.parseData(new LoadingResources());
			m_progress = 0;
        }
		
		//public function load(_assets:Vector.<Resource>, _onLoad:Function):void
		//{
			//if(m_resources.validate
			// TODO: implement this!!!
			// check if there are new assets that need to be loaded
			// if not, just call the callback (_onLoad);
			
			// unload and free unused assets to release resources
			// load new assets displaying the loading screen with percentage
			// when all assets are loaded and parsed, fade out the loading screen
		//}
         
        private function onDataParsed(_e:Event):void
        {
			m_armature = new StarlingArmature(m_factory.buildArmature("peluca"));
			m_sprite = m_armature.display as Sprite;
			m_sprite.x = 870;
			m_sprite.y = 650;
			m_sprite.scaleX = 0.3;
			m_sprite.scaleY = 0.3;
			addChild(m_sprite);

			Starling.juggler.add(m_armature);
			m_armature.animation.gotoAndPlay("loop", -1, -1, true);
		}
	}

}