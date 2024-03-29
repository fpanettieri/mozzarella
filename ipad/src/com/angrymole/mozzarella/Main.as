package com.angrymole.mozzarella
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import starling.core.Starling;
	
	/**
	 * Initializes starling and create the game
	 * Handles the loss of context, storing the current game state
	 * @author Fabio R. Panettieri
	 */
	[SWF(width="1024", height="768", frameRate="30", backgroundColor="#2B2E36")]
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			Starling.multitouchEnabled = false;
			_starling = new Starling(Game, stage);
			_starling.start();
			_starling.showStats = true;
		}
		
		private function deactivate(e:Event):void 
		{
			// TODO: Store game state
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}