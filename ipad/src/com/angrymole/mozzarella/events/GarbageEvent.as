package com.angrymole.mozzarella.events
{
	/**
	 * Events related to the piece garbage
	 * 
	 * @author fpanettieri
	 */
	public class GarbageEvent extends MozzarellaEvent
	{
		public static const GARBAGE_ADDED:String = "garbageAddedEvent";
		
		public function GarbageEvent (type:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
		}
	}
}
