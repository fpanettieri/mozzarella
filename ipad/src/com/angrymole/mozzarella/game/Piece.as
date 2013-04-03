package com.angrymole.mozzarella.game 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Piece extends Sprite 
	{
		private var m_row:int;
		private var m_column:int;
		private var m_type:PieceType;
		private var m_size:int;
		private var m_swappable:Boolean;
		private var m_selected:Boolean;
		
		private var m_placeholder:Placeholder;
		
		public function Piece(_row:int, _column:int, _type:PieceType, _size:int, _swappable:Boolean) 
		{
			m_row = _row;
			m_column = _column;
			m_type = _type;
			m_size = _size;
			m_swappable = _swappable;
			m_selected = false;
			
			m_placeholder = new Placeholder(_size, _size, m_type.color);
			addChild(m_placeholder);
			
			// TODO: play intro animation
		}
		
		public function get row():int 
		{
			return m_row;
		}
		
		public function get column():int 
		{
			return m_column;
		}
		
		public function get type():PieceType 
		{
			return m_type;
		}
		
		public function get size():int 
		{
			return m_size;
		}
		
		public function get swappable():Boolean 
		{
			return m_swappable;
		}
		
		public function toString():String
		{
			return "[Piece r: " + m_row + " c: " + m_column + " t: " + m_type + " ]";
		}
	}
}