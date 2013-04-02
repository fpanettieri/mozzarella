package com.angrymole.mozzarella
{
	import com.angrymole.mozzarella.screens.Playground;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Fabio R. Panettieri
	 */
	[SWF(width="1024", height="768", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			_starling = new Starling(Game, stage);
			_starling.start();
			_starling.showStats = true;
		}
		
		private function deactivate(e:Event):void 
		{
			// TODO: Store current state
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}