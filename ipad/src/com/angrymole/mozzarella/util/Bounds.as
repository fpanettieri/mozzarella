package com.angrymole.mozzarella.util 
{
	import flash.geom.Point;
	/**
	 * Determines a rectangle in space
	 * 
	 * @author Fabio R. Panettieri
	 */
	public class Bounds 
	{
		private var m_minX:Number;
		private var m_minY:Number;
		private var m_maxX:Number;
		private var m_maxY:Number;
		
		public function Bounds(_a:Point, _b:Point)
		{
			if (_a.x < _b.x) {
				m_minX = _a.x;
				m_maxX = _b.x;
			} else {
				m_minX = _b.x;
				m_maxX = _a.x;
			}
			
			if (_a.y < _b.y) {
				m_minY = _a.y;
				m_maxY = _b.y;
			} else {
				m_minY = _b.y;
				m_maxY = _a.y;
			}
		}
		
		public function contains(_point:Point):Boolean
		{
			return m_minX <= _point.x && m_maxX >= _point.x && m_minY <= _point.y && m_maxY >= _point.y;
		}
		
		public function get minX():int 
		{
			return m_minX;
		}
		
		public function set minX(value:int):void 
		{
			m_minX = value;
		}
		
		public function get minY():int 
		{
			return m_minY;
		}
		
		public function set minY(value:int):void 
		{
			m_minY = value;
		}
		
		public function get maxX():int 
		{
			return m_maxX;
		}
		
		public function set maxX(value:int):void 
		{
			m_maxX = value;
		}
		
		public function get maxY():int 
		{
			return m_maxY;
		}
		
		public function set maxY(value:int):void 
		{
			m_maxY = value;
		}		
		
		public function toString():String
		{
			return "[Bounds minX: " + m_minX + " minY: " + m_minY + " maxX: " + m_maxX + " maxY: " + m_maxY + "]";
		}
	}
}