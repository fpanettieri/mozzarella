package com.angrymole.mozzarella.events
{
	/**
	 * Used to notify time travels
	 * @author fpanettieri
	 */
	public class VacuumEvent extends MozzarellaEvent
	{
		public static const VACUUM_TRIGGER:String = "vacuumTriggerEvent";
		public static const VACUUM_PREPARED:String = "vacuumPreparedEvent";
		public static const VACUUM_STARTED:String = "vacuumStartedEvent";
		public static const VACUUM_COMPLETE:String = "vacuumCompleteEvent";
		
		public function VacuumEvent(type:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
		}
	}
}
