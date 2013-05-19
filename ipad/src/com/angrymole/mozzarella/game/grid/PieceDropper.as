package com.angrymole.mozzarella.game.grid 
{
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.game.piece.Piece;

	
	/**
	 * Used to make pieces fall in the grid
	 * 
	 * @author Fabio Panettieri
	 */
	public class PieceDropper
	{
		private var m_grid:Grid;
		
		public function PieceDropper(_grid:Grid) 
		{
			m_grid = _grid;
		}
		
		public function onGroupsBroken(_event:GroupsBrokenEvent):void
		{
			for (var column:int = 0; column < m_grid.columns; column++) {
				for (var row:int = 0; row < m_grid.rows; row++) {
					if ( !m_grid.cells[row][column].empty ) { continue; }
					if ( !fillCell(row, column)) { break; }
				}
			}
		}

		private function fillCell(_row:int, _column:int):Boolean
		{
			for (var row:int = _row; row < m_grid.rows; row++) {
				if (m_grid.cells[row][_column].empty ) { continue; }
				
				var piece:Piece = m_grid.cells[row][_column].piece;
				m_grid.cells[_row][_column].piece = piece;
				m_grid.cells[row][_column].piece = null;
				piece.ungroup();
				piece.drop(row, _row);
				
				return true;
			}
			return false;
		}
	}

}