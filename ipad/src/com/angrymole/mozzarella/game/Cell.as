package com.angrymole.mozzarella.game 
{
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class Cell 
	{
		private var m_row:int;
		private var m_column:int;
		private var m_piece:Piece;
		
		// TODO: track reference to the piece and the cell
		
		public function Cell(_row:int, _column:int, _piece:Piece = null) 
		{
			m_row = _row;
			m_column = _column;
			m_piece = _piece;
		}
		
		public function get row():int 
		{
			return m_row;
		}
		
		public function get column():int 
		{
			return m_column;
		}
		
		public function get empty():Boolean 
		{
			return m_piece == null;
		}
		
		public function get piece():Piece 
		{
			return m_piece;
		}
		
		public function set piece(value:Piece):void 
		{
			m_piece = value;
		}
	}

}