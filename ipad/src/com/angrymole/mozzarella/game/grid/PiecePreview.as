package com.angrymole.mozzarella.game.grid 
{
	import com.angrymole.mozzarella.constants.Constants;
	import com.angrymole.mozzarella.game.piece.Piece;
	import com.angrymole.mozzarella.util.Placeholder;
	import starling.display.Sprite;
	
	/**
	 * Used to display where the piece will be placed
	 * 
	 * @author Fabio Panettieri
	 */
	public class PiecePreview extends Sprite
	{
		private var m_piece:Piece;
		private var m_placeholder:Placeholder;
		
		public function PiecePreview(_piece:Piece) 
		{
			m_piece = _piece;
			m_placeholder = new Placeholder(_piece.size, _piece.size, _piece.type.color);
			m_placeholder.alpha = 0.5;
			addChild(m_placeholder);
		}
		
		public function update(_grid:Grid):void
		{
			var column:int = Math.round((m_piece.x + Constants.GRABBED_MARGIN) / m_piece.size);
			var empty:int = 0;
			for ( var row:int = _grid.rows - 1; row > -1; row--) {
				if (_grid.cells[row][column].empty) {
					empty = row;
				} else {
					break;
				}
			}
			
			x = _grid.x + column * m_piece.size;
			y = _grid.y + empty  * m_piece.size;
		}
	}
}