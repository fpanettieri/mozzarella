package com.angrymole.mozzarella.game.powerups 
{
	import com.angrymole.mozzarella.events.GroupEvent;
	import com.angrymole.mozzarella.events.PowerupEvent;
	import com.angrymole.mozzarella.game.grid.Cell;
	import com.angrymole.mozzarella.game.grid.Grid;
	import com.angrymole.mozzarella.game.piece.Piece;
	import com.angrymole.mozzarella.game.ui.Score;
	
	import starling.display.Sprite;
	
	/**
	 * Remove pieces from the grid when the undo button is pressed
	 * 
	 * @author Fabio Panettieri
	 */
	public class Vacuum extends Sprite
	{
		private static const PIECE_COST:int = 70;
		private static const MAX_GARBAGE:int = 10;
		
		// injected dependencies
		private var m_grid:Grid;
		private var m_score:Score;
		
		public function Vacuum(_grid:Grid, _score:Score) 
		{
			m_grid = _grid;
			m_score = _score;
		}
		
		public function vacuum(_event:PowerupEvent):void
		{
			// todo: pause the spawner countdown (this might be done listening to the powerupevent maybe, no actually a special
			// SpawnerEvent.PAUSE_COUNTDOWN
			// SpawnerEvent.RESUME_COUNTOWN 
			// sound better
			
			var pieces:Vector.<Piece> = findGarbage();
			
			// todo: check how many pieces the player can pay for
			// discount those points
			// remove pieces from the grid
			// drop pieces
			// play vacuum animation
			// dispatch restore animation
		
			trace(pieces.length);
		}
		
		public function findGarbage():Vector.<Piece>
		{
			var pieces:Vector.<Piece> = new Vector.<Piece>();
			var cell:Cell;
			for ( var row:int = m_grid.rows - 1; row > -1; row-- ) {
				for ( var column:int = 0; column < m_grid.columns - 1; column++ ) {
					cell = m_grid.cells[row][column];
					if (cell.empty || cell.piece.grouped || isLocked(cell.piece)) { continue; }
					pieces.push(cell.piece);
				}
			}
			return pieces;
		}
		
		private function isLocked(_piece:Piece):Boolean
		{
			for ( var row:int = _piece.row; row < m_grid.rows - 1; row++ ) {
				if ( m_grid.cells[row][_piece.column].empty ) { return false; }
				if ( m_grid.cells[row][_piece.column].piece.grouped ) { return true; }
			}
			return false;
		}
	}
}