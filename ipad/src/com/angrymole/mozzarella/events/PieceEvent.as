package com.angrymole.mozzarella.events
{
	import com.angrymole.mozzarella.game.piece.Piece;
	
	/**
	 * Used to notify piece related events
	 * @author fpanettieri
	 */
	public class PieceEvent extends MozzarellaEvent
	{
		public static const PIECE_UPDATED:String = "pieceUpdatedEvent";
		public static const PIECE_MOVED:String = "pieceMovedEvent";
		public static const PIECE_BROKEN:String = "pieceBrokenEvent";
		
		private var m_piece:Piece;
		
		public function PieceEvent(type:String, piece:Piece, bubbles:Boolean = false)
		{
			super(type, bubbles);
			m_piece = piece;
		}
		
		public function get piece():Piece 
		{
			return m_piece;
		}
	}
}
