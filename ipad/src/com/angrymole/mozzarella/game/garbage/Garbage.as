package com.angrymole.mozzarella.game.garbage 
{
	import com.angrymole.mozzarella.events.GameOverEvent;
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
			updateGrid();
			addGarbage();
			groupGarbage();
		}
		
		private function checkGameOver():void
		{
			for ( var column:int = 0; column < m_grid.columns; column++ ) {
				if ( m_grid.cells[m_grid.rows - 1][column].empty ) { continue; }
				dispatchEvent(new GameOverEvent(GameOverEvent.GAME_OVER));
			}
		}
		
		private function pushPieces():void
		{
			var piece:Piece;
			for ( var i:int = 0; i < m_grid.pieces.length; i++ ) {
				piece = m_grid.pieces[i];
				piece.push();
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
		
		private function updateGrid():void
		{
			for (var row:int = m_grid.rows - 1; row > 0; row--) {
				for (var column:int = 0; column < m_grid.columns ; column++) {
					m_grid.cells[row][column] = m_grid.cells[row - 1][column];
				}
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
		}
		
		private function groupGarbage():void
		{
			m_grid.groupPieces();
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