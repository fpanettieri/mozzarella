package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.GroupEvent;
	import com.angrymole.mozzarella.events.PowerupEvent;
	
	import starling.display.Sprite;
	
	/**
	 * Remove pieces from the grid when the undo button is pressed
	 * 
	 * @author Fabio Panettieri
	 */
	public class UndoMoves
	{
		private var m_grid:Grid;
		
		public function UndoMoves(_grid:Grid) 
		{
			m_grid = _grid;
		}
		
		public function undo():void
		{
			var iteration:int = -1;
			for each( var piece:Piece in m_grid.pieces) {
				if (piece.iteration <= iteration) { continue; }
				iteration = piece.iteration;
			}
			if (iteration == -1) { return; }
			
			var cell:Cell;
			for (var row:int = 0; row < m_grid.rows; row++) {
				for (var column:int = 0; column < m_grid.columns; column++) {
					cell = m_grid.cells[row][column];
					if ( cell.empty ) { continue; }
					if ( cell.piece.iteration == iteration) { cell.piece.vanish(); }
				}
			}
		}
	}
}