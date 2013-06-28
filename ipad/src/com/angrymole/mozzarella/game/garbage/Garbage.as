package com.angrymole.mozzarella.game.garbage 
{
	import com.angrymole.mozzarella.events.GameOverEvent;
	import com.angrymole.mozzarella.events.GarbageEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.game.core.Configuration;
	import com.angrymole.mozzarella.game.grid.Grid;
	import com.angrymole.mozzarella.game.piece.Group;
	import com.angrymole.mozzarella.game.piece.Piece;
	import com.angrymole.mozzarella.game.piece.PieceType;
	import starling.events.EventDispatcher;
	/**
	 * Add a line of random pieces to 
	 * @author Fabio Panettieri
	 */
	public class Garbage extends EventDispatcher
	{
		// injected dependencies
		private var m_grid:Grid;
		private var m_types:Vector.<PieceType>;
		private var m_pieceSize:int;
		
		private var m_intervals:int;
		private var m_spawns:int;
		
		// aux vars
		private var m_piece:Piece;
		private var m_group:Piece;
		
		public function Garbage(_intervals:int)
		{
			m_intervals = _intervals;
			m_spawns = 0;
		}
		
		public function onSpawn(_event:SpawnEvent):void
		{
			if (++m_spawns < m_intervals) { return; }
			m_spawns = 0;
			
			checkGameOver();
			pushPieces();
			pushGroups();
			addGarbage();
			
			// FIXME: check spawned pieces are not from the same type of the piece below
		}
		
		private function checkGameOver():void
		{
			for ( var column:int = 0; column < m_grid.columns; column++ ) {
				if ( m_grid.isCellEmpty(m_grid.rows - 1, column) ) { continue; }
				dispatchEvent(new GameOverEvent(GameOverEvent.GAME_OVER));
			}
		}
		
		private function pushPieces():void
		{
			for ( var i:int = 0; i < m_grid.pieces.length; i++ ) {
				m_piece = m_grid.pieces[i];
				m_piece.push();
			}
		}
		
		private function pushGroups():void
		{
			var group:Group;
			for ( var i:int = 0; i < m_grid.groups.length; i++ ) {
				group = m_grid.groups[i];
				group.push();
			}
		}
	 	
		private function addGarbage():void
		{
			var piece:Piece;
			for (var column:int = 0; column < m_grid.columns; column++) {
				piece = new Piece(0, column,  m_types[ Math.floor( Math.random() * m_types.length ) ], m_pieceSize);
				
				// TODO: animate garbage
				m_grid.dropPiece( piece );
			}
			dispatchEvent(new GarbageEvent(GarbageEvent.GARBAGE_ADDED));
		}
		
		public function set grid(value:Grid):void 
		{
			m_grid = value;
		}
		
		public function set types(value:Vector.<PieceType>):void 
		{
			m_types = value;
		}
		
		public function set pieceSize(value:int):void 
		{
			m_pieceSize = value;
		}
	}
}