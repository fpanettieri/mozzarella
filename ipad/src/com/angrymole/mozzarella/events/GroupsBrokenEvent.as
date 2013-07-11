package com.angrymole.mozzarella.events
{
	import com.angrymole.mozzarella.game.piece.PieceType;
	import flash.geom.Point;
	
	/**
	 * Used to notify that groups have been broken
	 * Score has to be recalculated an piecs in the gris should be repositioned
	 * 
	 * @author fpanettieri
	 */
	public class GroupsBrokenEvent extends MozzarellaEvent
	{
		public static const GROUPS_BROKEN:String = "groupsBrokenEvent";
		
		private var m_pieces:int;
		private var m_groups:int;
		private var m_centroid:Point;
		private var m_pieceType:PieceType;
		
		public function GroupsBrokenEvent(type:String, pieces:int, groups:int, centroid:Point, pieceType:PieceType)
		{
			super(type, bubbles);
			m_pieces = pieces;
			m_groups = groups;
			m_centroid = centroid;
			m_pieceType = pieceType;
		}
		
		public function get pieces():int 
		{
			return m_pieces;
		}
		
		public function get groups():int 
		{
			return m_groups;
		}
		
		public function get centroid():Point 
		{
			return m_centroid;
		}
		
		public function get pieceType():PieceType 
		{
			return m_pieceType;
		}
	}
}
