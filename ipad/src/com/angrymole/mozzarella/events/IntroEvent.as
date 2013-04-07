package com.angrymole.mozzarella.events
{
	/**
	 * Events related to the game introduction
	 * 
	 * @author fpanettieri
	 */
	public class IntroEvent extends MozzarellaEvent
	{
		public static const INTRO_STARTED:String = "introStartedEvent";
		public static const INTRO_COMPLETE:String = "introCompletedEvent";
		
		public function IntroEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
		}
	}
}
