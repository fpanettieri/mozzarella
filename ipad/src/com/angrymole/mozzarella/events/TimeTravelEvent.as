package com.angrymole.mozzarella.events
{
	import com.angrymole.mozzarella.game.Piece;
	
	/**
	 * Used to notify time travels
	 * @author fpanettieri
	 */
	public class TimeTravelEvent extends MozzarellaEvent
	{
		public static const TIME_TRAVEL:String = "timeTravelEvent";
		
		public function TimeTravelEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
		}
	}
}
