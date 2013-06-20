package com.angrymole.mozzarella.game.powerups 
{
	import com.angrymole.mozzarella.events.GroupEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.events.VacuumEvent;
	import com.angrymole.mozzarella.game.grid.Cell;
	import com.angrymole.mozzarella.game.grid.Grid;
	import com.angrymole.mozzarella.game.piece.Piece;
	import com.angrymole.mozzarella.game.score.Score;
	import flash.events.TimerEvent;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	
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
		
		private var m_prepared:Boolean;
		private var m_garbage:Vector.<Piece>;
		private var m_payable:int;
		
		private var m_delayedCall:DelayedCall;
		
		public function Vacuum(_grid:Grid, _score:Score) 
		{
			m_grid = _grid;
			m_score = _score;
			
			m_prepared = false;
			m_garbage = new Vector.<Piece>();
		}
		
		public function onVacuumTrigger(_event:VacuumEvent):void
		{
			if (!m_prepared) { prepareVacuum(); }
			else { removeGarbage(); }
		}
		
		private function prepareVacuum():void
		{
			m_prepared = true;
			
			findGarbage();
			m_payable = int(m_score.score / PIECE_COST);
			m_garbage.length = Math.min( Math.min( m_payable, MAX_GARBAGE ), m_garbage.length );
			
			for (var i:int = 0; i < m_garbage.length; i++) {
				m_garbage[i].shake();
			}
			
			m_delayedCall = Starling.juggler.delayCall(resetVacuum, 4);
			dispatchEvent(new VacuumEvent(VacuumEvent.VACUUM_PREPARED));
		}
		
		private function removeGarbage():void
		{
			m_prepared = false;
			dispatchEvent(new VacuumEvent(VacuumEvent.VACUUM_STARTED));
			
			if (!m_delayedCall.isComplete) {
				Starling.juggler.remove(m_delayedCall);
				m_delayedCall = null;
			}
			
			m_score.reduceScore(m_garbage.length * PIECE_COST);
			for (var i:int = 0; i < m_garbage.length; i++) {
				m_grid.removePiece(m_garbage[i]);
			}
			m_grid.dropPieces();
			
			// TODO: play vacuum animation
			// dispatch restore animation
			
			dispatchEvent(new VacuumEvent(VacuumEvent.VACUUM_COMPLETE));
		}
		
		private function resetVacuum():void
		{
			m_prepared = false;
		}
		
		private function findGarbage():void
		{
			m_garbage.length = 0;
			var cell:Cell;
			for ( var row:int = m_grid.rows - 1; row > -1; row-- ) {
				for ( var column:int = 0; column < m_grid.columns; column++ ) {
					cell = m_grid.cells[row][column];
					if (cell.empty || cell.piece.grouped || isLocked(cell.piece)) { continue; }
					m_garbage.splice(int(Math.random() * m_garbage.length), 0, cell.piece);
				}
			}
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