package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.IntroEvent;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * Dispatch the IntroStarted event
	 * Displays the 3,2,1 go animation
	 * Make the pieces appear in order
	 * Dispatch the IntroComplete event
	 * 
	 * @author Fabio Panettieri
	 */
	public class Intro extends Sprite 
	{
		public function Intro() 
		{
			dispatchEvent(new IntroEvent(IntroEvent.INTRO_STARTED));
			// TODO: implement real intro
			
			Starling.juggler.delayCall(fakeIntro, 1.0);
		}
		
		private function fakeIntro():void
		{
			dispatchEvent(new IntroEvent(IntroEvent.INTRO_COMPLETE));
		}
	}
}