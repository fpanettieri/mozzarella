package com.angrymole.mozzarella.events
{
	import com.angrymole.mozzarella.screens.Screen;
	
	/**
	 * @author fpanettieri
	 */
	public class ScreenEvent extends MozzarellaEvent
	{
		public static const ADD_SCREEN:String = "addScreenEvent";
		public static const SWITCH_SCREEN:String = "switchScreenEvent";
		public static const REMOVE_SCREEN:String = "removeScreenEvent";
		public static const SCREEN_LOADED:String = "screenLoadedEvent";
		
		private var m_screen:Screen;
		
		public function ScreenEvent(type:String, screen:Screen, bubbles:Boolean = false)
		{
			super(type, bubbles);
			m_screen = screen;
		}
		
		public function get screen():Screen
		{
			return m_screen;
		}
	}
}
