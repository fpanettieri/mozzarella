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
		private var m_piece:Piece;
		
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
			for (var row:int = m_grid.rows - 1; row > 0; row--) {
				for (var column:int = 0; column < m_grid.columns ; column++) {
					m_piece = m_grid.getPiece(row, column);
					if (m_piece == null || m_piece.grouped) { continue; }
					group(m_piece);
				}
			}
		}
		
		private function groupLeft(_piece:Piece):void
		{
			if (_piece.column == 0) { return; }
			
			var cells:Vector.<Piece> = new Vector.<Piece>()
			cells.push(m_grid.getPiece(_piece.row - 1, _piece.column - 1));
			cells.push(m_grid.getPiece(_piece.row - 1, _piece.column));
			cells.push(m_grid.getPiece(_piece.row, _piece.column - 1));
			cells.push(m_grid.getPiece(_piece.row, _piece.column));
			
			groupCells(_piece, cells);
		}
	
		private function groupRight(_piece:Piece):void
		{
			if (_piece.column == m_grid.columns - 1) { return; }
			
			var cells:Vector.<Piece> = new Vector.<Piece>()
			cells.push(m_grid.getPiece(_piece.row - 1, _piece.column));
			cells.push(m_grid.getPiece(_piece.row - 1, _piece.column + 1));
			cells.push(m_grid.getPiece(_piece.row, _piece.column));
			cells.push(m_grid.getPiece(_piece.row, _piece.column + 1));
			
			groupCells(_piece, cells);
		}
		
		private function groupCells(_piece:Piece, _pieces:Vector.<Piece>):void
		{
			for ( var i:int = 0; i < _pieces.length; i++) {
				if (_pieces[i] == null || _pieces[i].grouped || !_pieces[i].type.equals(_piece.type)) {
					return;
				}
			}
			
			var group:Group = new Group(_pieces[0], _pieces[1], _pieces[2], _pieces[3]);				
			dispatchEvent(new GroupEvent(GroupEvent.GROUP_CREATED, group));
		}
	}

}