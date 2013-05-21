package com.angrymole.mozzarella 
{
	import com.angrymole.mozzarella.events.ScreenEvent;
	import com.angrymole.mozzarella.game.core.Assets;
	import com.angrymole.mozzarella.screens.loading.Loading;
	import com.angrymole.mozzarella.screens.Screen;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	
	/**
	 * Control screen flow
	 * @author Fabio R. Panettieri
	 */
	public class Game extends Sprite
	{
		private var m_assets:Assets;
		private var m_loading:Loading;
		private var m_screens:Vector.<Screen>;
		
		public static function get current():Game
		{
			return Starling.current.root as Game;
		}
		
		public function Game()
		{
			m_screens = new Vector.<Screen>();
			m_loading = new Loading();
			addScreen(m_loading);
			
			//m_assets = new Assets();
			//m_assets.load(onProgress, onComplete);
			// TODO: add loading screen
		}
		
		private function onProgress(_progress:Number):void
		{
			// TODO: update loading screen progress
		}
		
		private function onComplete():void
		{
			//addScreen(new Playground());
		}
		
		public function addScreen(_screen:Screen):void
		{
			addListeners(_screen);
			m_screens.push(_screen);
			addChild(_screen);
		}
		
		public function switchScreen(_screen:Screen):void
		{
			removeAll();
			addScreen(_screen);
		}
		
		public function removeScreen(_screen:Screen):void
		{
			var pos:int = m_screens.indexOf(_screen);
			if(pos == -1){
				throw new Error("Screen not found: " + _screen);
			}
			
			m_screens.splice(pos, 1);
			removeChild(_screen);
			removeListeners(_screen);
		}
		
		public function removeAll():void
		{
			for each(var screen:Screen in m_screens){
				removeScreen(screen);
			}
		}
		
		public function topScreen():Screen
		{
			return m_screens[m_screens.length - 1];
		}
		
		public function get assets():AssetManager
		{
			return m_assets.manager;
		}
		
		private function addListeners(_screen:Screen):void
		{
			_screen.addEventListener(ScreenEvent.ADD_SCREEN, handleAddScreen);
			_screen.addEventListener(ScreenEvent.REMOVE_SCREEN, handleRemoveScreen);
			_screen.addEventListener(ScreenEvent.SWITCH_SCREEN, handleSwitchScreen);
		}
		
		private function removeListeners(_screen:Screen):void
		{
			_screen.removeEventListener(ScreenEvent.ADD_SCREEN,  handleAddScreen);
			_screen.removeEventListener(ScreenEvent.REMOVE_SCREEN, handleRemoveScreen);
			_screen.removeEventListener(ScreenEvent.SWITCH_SCREEN, handleSwitchScreen);
		}
		
		private function handleAddScreen(_event:ScreenEvent):void
		{
			addScreen(_event.screen);
		}
		
		private function handleRemoveScreen(_event:ScreenEvent):void
		{
			removeScreen(_event.screen);
		}
		
		private function handleSwitchScreen(_event:ScreenEvent):void
		{
			switchScreen(_event.screen);
		}
	}
}