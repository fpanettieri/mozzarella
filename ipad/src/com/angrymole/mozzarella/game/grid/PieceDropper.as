package com.angrymole.mozzarella.game.grid 
{
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.game.piece.Piece;

	
	/**
	 * Used to make pieces fall in the grid
	 * 
	 * @author Fabio Panettieri
	 */
	public class PieceDropper
	{
		private var m_grid:Grid;
		private var m_piece:Piece;
		
		public function PieceDropper(_grid:Grid) 
		{
			m_grid = _grid;
		}
		
		public function dropPieces():void
		{
			for (var column:int = 0; column < m_grid.columns; column++) {
				for (var row:int = 0; row < m_grid.rows; row++) {
					if ( !m_grid.isCellEmpty(row, column)) { continue; }
					if ( !fillCell(row, column)) { break; }
				}
			}
		}

		private function fillCell(_row:int, _column:int):Boolean
		{
			for (var row:int = _row; row < m_grid.rows; row++) {
				if (m_grid.isCellEmpty(row,_column)) { continue; }
				m_piece = m_grid.getPiece(row, _column);
				m_piece.ungroup();
				m_piece.drop(row, _row);
				return true;
			}
			return false;
		}
	}

}