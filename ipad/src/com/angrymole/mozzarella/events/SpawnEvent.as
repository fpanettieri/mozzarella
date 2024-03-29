package com.angrymole.mozzarella.events
{
	import com.angrymole.mozzarella.game.piece.Piece;
	
	/**
	 * Events related to piece spawn
	 * 
	 * @author fpanettieri
	 */
	public class SpawnEvent extends MozzarellaEvent
	{
		public static const SPAWN_TRIGGER:String = "spawnTriggerEvent";
		public static const SPAWN_STARTED:String = "spawnStartedEvent";
		public static const SPAWN_PIECE:String = "spawnPieceEvent";
		public static const SPAWN_SWAPPABLE:String = "spawnSwappableEvent";
		public static const SPAWN_LOCKED:String = "spawnLockedEvent";
		public static const SPAWN_COMPLETE:String = "spawnCompleteEvent";
		
		private var m_pieces:Vector.<Piece>;
		
		public function SpawnEvent (type:String, pieces:Vector.<Piece> = null, bubbles:Boolean = false)
		{
			super(type, bubbles);
			m_pieces = pieces;
		}
		
		public function get pieces():Vector.<Piece> 
		{
			return m_pieces;
		}
	}
}
