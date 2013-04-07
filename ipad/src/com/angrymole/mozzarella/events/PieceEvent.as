package com.angrymole.mozzarella.events
{
	import com.angrymole.mozzarella.game.Piece;
	
	/**
	 * Used to notify piece related events
	 * @author fpanettieri
	 */
	public class PieceEvent extends MozzarellaEvent
	{
		public static const PIECE_SPAWNED:String = "pieceSpawnedEvent";
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
