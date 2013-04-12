package com.angrymole.mozzarella.gestures 
{
	import com.angrymole.mozzarella.util.Bounds;
	import flash.geom.Point;
	
	/**
	 * Indicates a displacement of the finger
	 * 
	 * It's not accurate when the finger moves too fast because it skips
	 * possible intermediate points that could have been sampled
	 * 
	 * But it's pretty accurate for sampling fast finger moves
	 * 
	 * @author Fabio Panettieri
	 */
	public class Swipe extends Gesture 
	{
		private var m_direction:Number;
		private var m_bounds:Bounds;
		
		public function Swipe(_begin:Point, _end:Point, _duration:Number) 
		{
			super(_begin, _end, _duration);
			m_direction = SwipeDirection.getDirection(m_begin, m_end);
			m_bounds = new Bounds(m_begin, m_end);
		}
		
		public function get direction():Number 
		{
			return m_direction;
		}
		
		public function get bounds():Bounds 
		{
			return m_bounds;
		}
		
		public function get length():Number 
		{
			return Point.distance(m_begin, m_end);
		}
		
		override public function toString():String
		{
			return "[Swipe begin: " + m_begin.x + "," + m_begin.y + " end: " + m_end.x + "," + 
				m_end.y + " duration: " + m_duration + " direction: " + m_direction + "]";
		}
	}
}