package com.angrymole.mozzarella.gestures 
{
	import flash.geom.Point;
	/**
	 * Each part of a Path
	 * 
	 * @author Fabio Panettieri
	 */
	public class Section 
	{
		private var m_begin:Point;
		private var m_end:Point;
		
		public function Section(_begin:Point, _end:Point) 
		{
			m_begin = _begin;
			m_end = _end;
		}
		
		public function length():Number
		{
			return Point.distance(m_begin, m_end);
		}
		
		public function get begin():Point 
		{
			return m_begin;
		}
		
		public function get end():Point 
		{
			return m_end;
		}
		
	}

}