package com.angrymole.mozzarella.events
{
	/**
	 * Events related to the game ending
	 * 
	 * @author fpanettieri
	 */
	public class GameOverEvent extends MozzarellaEvent
	{
		public static const GAME_OVER:String = "gameOverEvent";
		
		public function GameOverEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
		}
	}
}
