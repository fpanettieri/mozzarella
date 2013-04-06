package com.angrymole.mozzarella.gestures 
{
	import flash.geom.Point;
	/**
	 * A touch in a single point
	 * 
	 * @author Fabio Panettieri
	 */
	public class Tap extends Gesture 
	{
		private var m_x:Number;
		private var m_y:Number;
		
		public function Tap(_begin:Point, _end:Point, _duration:Number) 
		{
			super(_begin, _end, _duration);
			
			m_x = _begin.x;
			m_y = _begin.y;
		}
		
		public function get x():Number 
		{
			return m_x;
		}
		
		public function get y():Number 
		{
			return m_y;
		}
		
		override public function toString():String
		{
			return "[Tap x: " + m_x + " y: " + m_y + " duration: " + m_duration + "]";
		}
	}
}