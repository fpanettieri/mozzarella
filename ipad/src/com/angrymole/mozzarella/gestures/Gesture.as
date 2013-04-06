package com.angrymole.mozzarella.gestures 
{
	import flash.geom.Point;
	
	/**
	 * Identifies a defined gesture
	 * All gestures store the poin where it was originated
	 * The point where it was closed, and how much time the used took to make it
	 * 
	 * @author Fabio Panettieri
	 */
	public class Gesture 
	{
		protected var m_begin:Point;
		protected var m_end:Point;
		protected var m_duration:Number;
		
		public function Gesture(_begin:Point, _end:Point, _duration:Number) 
		{
			m_begin = _begin;
			m_end = _end;
			m_duration = _duration;
		}
		
		public function get begin():Point 
		{
			return m_begin;
		}
		
		public function get end():Point 
		{
			return m_end;
		}
		
		public function get duration():Number 
		{
			return m_duration;
		}
	}
}