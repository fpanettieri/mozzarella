package com.angrymole.mozzarella.events
{
	import com.angrymole.mozzarella.game.Piece;
	
	/**
	 * Used to notify time travels
	 * @author fpanettieri
	 */
	public class PowerupEvent extends MozzarellaEvent
	{
		public static const UNDO_MOVE:String = "undoMoveEvent";
		public static const FREEZE_TIME:String = "freezeTimeEvent";
		public static const BLACK_HOLE:String = "blackHoleEvent";
		
		public function PowerupEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
		}
	}
}
