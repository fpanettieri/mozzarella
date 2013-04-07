package com.angrymole.mozzarella.events 
{
	import com.angrymole.mozzarella.gestures.Gesture;
	
	/**
	 * Gesture related events
	 * 
	 * @author fpanettieri
	 */
	public class GestureEvent extends MozzarellaEvent
	{
		public static const TAP_GESTURE:String = "tapGestureEvent";
		public static const SWIPE_GESTURE:String = "swipeGestureEvent";
		public static const PATH_GESTURE:String = "pathGestureEvent";
		
		private var m_gesture:Gesture;
		
		public function GestureEvent(type:String, gesture:Gesture, bubbles:Boolean = false)
		{
			super(type, bubbles);
			m_gesture = gesture;
		}
		
		public function get gesture():Gesture 
		{
			return m_gesture;
		}
	}
}