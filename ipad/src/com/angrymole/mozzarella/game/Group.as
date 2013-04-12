package com.angrymole.mozzarella.game 
{
	import starling.display.Sprite;
	
	/**
	 * A group of 4 pieces
	 * 
	 * @author Fabio Panettieri
	 */
	public class Group extends Sprite 
	{
		private var m_tl:Piece;
		private var m_tr:Piece;
		private var m_bl:Piece;
		private var m_br:Piece;
		
		private var m_placeholder:Placeholder;
		
		public function Group(_tl:Piece, _tr:Piece, _bl:Piece, _br:Piece)
		{
			m_tl = _tl;
			m_tr = _tr;
			m_bl = _bl;
			m_br = _br;
			
			m_placeholder = new Placeholder(_tl.size * 2, _tl.size * 2, _tl.type.color);
			addChild(m_placeholder);
		}
		
	}

}