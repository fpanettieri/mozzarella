package com.angrymole.mozzarella.game 
{
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Grid extends Sprite 
	{
		private var m_rows:int;
		private var m_columns:int;
		
		private var m_pieces:Vector.<Piece>;
		
		private var m_placeholder:Placeholder;
		
		public function Grid(_cfg:Configuration) 
		{
			m_rows = _cfg.rows;
			m_columns = _cfg.columns;
			
			m_placeholder = new Placeholder(m_columns * _cfg.pieceSize, m_columns * _cfg.pieceSize, 0xffa40e63);
			addChild(m_placeholder);
			
			m_pieces = new Vector.<Piece>();
			m_pieces.push(new Piece(0xff9900ff));
			addChild(m_pieces[m_pieces.length - 1]);			
		}
	}
}