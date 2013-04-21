package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.GameOverEvent;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.game.Piece;
	import com.angrymole.mozzarella.gestures.Tap;
	import com.angrymole.mozzarella.interfaces.IUpdatable;
	import flash.geom.Point;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Grid extends Sprite
	{
		private var m_rows:int;
		private var m_columns:int;
		
		private var m_cells:Vector.<Vector.<Cell>>;
		private var m_pieces:Vector.<Piece>;
		
		private var m_placeholder:Placeholder;
		
		// TODO: create object that create groups
		// TODO: create object that break groups
		
		
		public function Grid(_cfg:Configuration) 
		{
			m_rows = _cfg.rows;
			m_columns = _cfg.columns;
			
			m_cells = new Vector.<Vector.<Cell>>( m_rows );
			for ( var row:int = 0; row < m_rows; row++) {
				m_cells[row] = new Vector.<Cell>( m_columns );
				
				for ( var column:int = 0; column < m_columns; column++) {
					// TODO: parse pieces from level
					m_cells[row][column] = new Cell(row, column);
				}
			}
			
			m_placeholder = new Placeholder(m_columns * _cfg.pieceSize, m_rows * _cfg.pieceSize, 0x9E373E);
			addChild(m_placeholder);
			
			m_pieces = new Vector.<Piece>();
		}
		
		public function push(_x:Number, _y:Number):void
		{
			trace("someone tapped me");
		}
		
		public function slash(_from:Point, _to:Point, _direciton:int, _strength:Number):void
		{
			trace("someone slashed me");
		}
		
		public function addPiece(_piece:Piece):void
		{
			addChild(_piece);
			_piece.y = m_rows * _piece.size + 15;
			_piece.addEventListener(PieceEvent.PIECE_DROPPED, onPieceDropped);
			
			var row:int = _piece.row;
			for ( row = m_rows - 1; row >= 0; row--){
				if ( !m_cells[row][_piece.column].empty ) {
					break;
				}
			}
			row++
			
			if (row >= m_rows) {
				dispatchEvent(new GameOverEvent(GameOverEvent.GAME_OVER));
			} else {
				m_cells[row][_piece.column].piece = _piece;
				_piece.drop(m_rows, row);	
			}
		}
		
		public function onSpawn(_event:SpawnEvent):void
		{
			for (var i:int = 0; i < _event.pieces.length; i++) {
				if (_event.pieces[i] == null) { continue; }
				addPiece(_event.pieces[i]);
			}
		}
		
		public function onPieceDropped(_event:PieceEvent):void
		{
			trace("piece event " + _event);
			// TODO: build groups
		}
		
		public function get cells():Vector.<Vector.<Cell>> 
		{
			return m_cells;
		}
		
		public function get rows():int 
		{
			return m_rows;
		}
		
		public function get columns():int 
		{
			return m_columns;
		}
	}
}