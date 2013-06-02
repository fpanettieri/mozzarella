package com.angrymole.mozzarella.events
{
	/**
	 * Used to notify time travels
	 * @author fpanettieri
	 */
	public class PowerupEvent extends MozzarellaEvent
	{
		public static const TRIGGER_VACUUM:String = "triggerVacuumEvent";
		
		public function PowerupEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
		}
	}
}
