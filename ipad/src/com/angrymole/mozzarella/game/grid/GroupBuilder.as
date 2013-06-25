package com.angrymole.mozzarella.game.grid 
{
	import com.angrymole.mozzarella.events.GroupEvent;
	import com.angrymole.mozzarella.game.piece.Group;
	import com.angrymole.mozzarella.game.piece.Piece;
	
	import starling.display.Sprite;
	
	/**
	 * Build group of pieces when 4 pieces 
	 * are next to each other in the grid
	 * 
	 * @author Fabio Panettieri
	 */
	public class GroupBuilder extends Sprite
	{
		private var m_grid:Grid;
		
		public function GroupBuilder(_grid:Grid) 
		{
			m_grid = _grid;
		}
		
		public function group(_piece:Piece):void
		{
			if (_piece.row == 0) { return; }
			
			groupLeft(_piece);
			groupRight(_piece);
		}
		
		public function groupPieces():void
		{
			var cell:Cell;
			for (var row:int = m_grid.rows - 1; row > 0; row--) {
				for (var column:int = 0; column < m_grid.columns ; column++) {
					cell = m_grid.cells[row][column];
					if (cell.empty || cell.piece.grouped) { continue; }
					group(cell.piece);
				}
			}
		}
		
		private function groupLeft(_piece:Piece):void
		{
			if (_piece.column == 0) { return; }
			
			var cells:Vector.<Cell> = new Vector.<Cell>()
			cells.push(m_grid.cells[_piece.row - 1][_piece.column - 1]);
			cells.push(m_grid.cells[_piece.row - 1][_piece.column]);
			cells.push(m_grid.cells[_piece.row][_piece.column - 1]);
			cells.push(m_grid.cells[_piece.row][_piece.column]);
			
			groupCells(_piece, cells);
		}
	
		private function groupRight(_piece:Piece):void
		{
			if (_piece.column == m_grid.columns - 1) { return; }
			
			var cells:Vector.<Cell> = new Vector.<Cell>()
			cells.push(m_grid.cells[_piece.row - 1][_piece.column]);
			cells.push(m_grid.cells[_piece.row - 1][_piece.column + 1]);
			cells.push(m_grid.cells[_piece.row][_piece.column]);
			cells.push(m_grid.cells[_piece.row][_piece.column + 1]);
			
			groupCells(_piece, cells);
		}
		
		private function groupCells(_piece:Piece, _cells:Vector.<Cell>):void
		{
			for ( var i:int = 0; i < _cells.length; i++) {
				if (_cells[i].empty || _cells[i].piece.grouped || !_cells[i].piece.type.equals(_piece.type)) {
					return;
				}
			}
			
			var group:Group = new Group(_cells[0].piece, _cells[1].piece, _cells[2].piece, _cells[3].piece);				
			dispatchEvent(new GroupEvent(GroupEvent.GROUP_CREATED, group));
		}
	}

}