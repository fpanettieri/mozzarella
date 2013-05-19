package com.angrymole.mozzarella.events
{
	/**
	 * Used to notify time travels
	 * @author fpanettieri
	 */
	public class PowerupEvent extends MozzarellaEvent
	{
		public static const VACUUM:String = "vacuumEvent";
		public static const FREEZE_TIME:String = "freezeTimeEvent";
		public static const BLACK_HOLE:String = "blackHoleEvent";
		
		public function PowerupEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
		}
	}
}
