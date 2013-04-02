package com.angrymole.mozzarella.events
{
	import starling.events.Event;
	
	/**
	 * Base class of all Mozzarella events
	 * Can be used to log events or something in the future
	 * 
	 * @author fpanettieri
	 */
	public class MozzarellaEvent extends Event
	{	
		public function MozzarellaEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
