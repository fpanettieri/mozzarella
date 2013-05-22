package com.angrymole.mozzarella.screens.loading 
{
	import com.angrymole.dragonbones.StarlingArmature;
	import com.angrymole.mozzarella.events.ScreenEvent;
	import com.angrymole.mozzarella.Game;
	import com.angrymole.mozzarella.screens.Screen;
	import dragonBones.animation.WorldClock;
	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
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
		private var m_text:TextField;
		
		private var m_progress:Number;

		public function Loading() 
		{
			m_factory = new StarlingFactory();
			m_factory.addEventListener(Event.COMPLETE, onDataParsed);
            m_factory.parseData(new LoadingResources());
			m_progress = 0;
			alpha = 0;
        }
		
		private function onDataParsed(_e:Event):void
        {
			m_armature = new StarlingArmature(m_factory.buildArmature("peluca"));
			m_sprite = m_armature.display as Sprite;
			m_sprite.x = 870;
			m_sprite.y = 650;
			m_sprite.scaleX = 0.3;
			m_sprite.scaleY = 0.3;
			addChild(m_sprite);
			
			m_text = new TextField(128, 40, "0 %");
			m_text.x = 750;
			m_text.y = 500;
			m_text.hAlign = HAlign.CENTER;
			m_text.vAlign = VAlign.CENTER;
			addChild(m_text);
			dispatchEvent(new ScreenEvent(ScreenEvent.SCREEN_LOADED, this));
		}
		
		public function onProgress(_progress:Number):void
		{
			m_progress = _progress * 100;
			m_text.text = m_progress.toFixed(1) + " %";
		}
		
		public function fadeIn():void
		{
			Starling.juggler.tween(this, 0.5, { alpha: 1 } );
			Starling.juggler.add(m_armature);
			m_armature.animation.gotoAndPlay("loop", -1, -1, true);
		}
		
		public function fadeOut():void
		{
			Starling.juggler.tween(this, 0.5, { alpha: 0, onComplete: onFadeOutComplete } );
			Starling.juggler.remove(m_armature);
		}
		
		private function onFadeOutComplete():void
		{
			m_armature.animation.stop();
			dispatchEvent( new ScreenEvent(ScreenEvent.REMOVE_SCREEN, this) );
		}
	}
}