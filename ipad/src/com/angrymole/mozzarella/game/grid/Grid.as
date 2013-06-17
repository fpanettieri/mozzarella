package com.angrymole.mozzarella.game.grid 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.XMLAsset;
	import com.angrymole.mozzarella.constants.PieceSize;
	import com.angrymole.mozzarella.events.GameOverEvent;
	import com.angrymole.mozzarella.events.GroupEvent;
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.game.core.Configuration;
	import com.angrymole.mozzarella.game.piece.Group;
	import com.angrymole.mozzarella.game.piece.Piece;
	import com.angrymole.mozzarella.game.piece.PieceType;
	import com.angrymole.mozzarella.game.powerups.Vacuum;
	import com.angrymole.mozzarella.util.Placeholder;
	
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
		private var m_groups:Vector.<Group>;
		
		private var m_grouper:GroupBuilder;
		private var m_breaker:GroupBreaker;
		private var m_dropper:PieceDropper;
		
		public function Grid(_cfg:Configuration) 
		{
			m_rows = _cfg.rows;
			m_columns = _cfg.columns;
			
			m_pieces = new Vector.<Piece>();
			m_groups = new Vector.<Group>();
			m_cells = new Vector.<Vector.<Cell>>( m_rows );
			
			for ( var row:int = 0; row < m_rows; row++) {
				m_cells[row] = new Vector.<Cell>( m_columns );
				
				for ( var column:int = 0; column < m_columns; column++) {
					// TODO: parse pieces from level
					m_cells[row][column] = new Cell(row, column);
				}
			}
			
			var asset:XMLAsset = Assets.i.getAsset("level") as XMLAsset;
			
			var piece:Piece;
			for each(var tile:XML in asset.xml.Wigs.tile) {
				piece = new Piece(tile.@y, tile.@x, PieceType.fromInt(tile.@id), PieceSize.BUFFERED, -1);
				addParsedPiece(piece);
			}
			
			m_grouper = new GroupBuilder(this);
			m_grouper.addEventListener(GroupEvent.GROUP_CREATED, onGroupCreated);
			
			m_dropper = new PieceDropper(this);
			
			m_breaker = new GroupBreaker(this);
			m_breaker.addEventListener(GroupEvent.GROUP_BROKEN, onGroupBroken);
			m_breaker.addEventListener(GroupsBrokenEvent.GROUPS_BROKEN, onGroupsBroken);
			addChild(m_breaker);
		}
		
		public function onSpawn(_event:SpawnEvent):void
		{
			for (var i:int = 0; i < _event.pieces.length; i++) {
				if (_event.pieces[i] == null) { continue; }
				addPiece(_event.pieces[i]);
			}
		}
		
		private function addPiece(_piece:Piece):void
		{
			m_pieces.push(_piece);
			addChild(_piece);
			_piece.y = (m_columns - 1) * _piece.size;
			_piece.addEventListener(PieceEvent.PIECE_DROPPED, onPieceDropped);
			_piece.addEventListener(PieceEvent.PIECE_BROKEN, onPieceBroken);
			
			var empty:int = 0;
			for ( var row:int = m_rows - 1; row > -1; row--) {
				if (m_cells[row][_piece.column].empty) {
					empty = row;
				} else {
					break;
				}
			}
			
			if (empty >= m_rows) {
				dispatchEvent(new GameOverEvent(GameOverEvent.GAME_OVER));
			} else {
				m_cells[empty][_piece.column].piece = _piece;
				_piece.drop(m_columns - 1, empty);	
			}
		}
		
		private function addParsedPiece(_piece:Piece):void
		{
			m_cells[_piece.row][_piece.column].piece = _piece;
			m_pieces.push(_piece);
			
			_piece.x = _piece.column * _piece.size;
			_piece.y = _piece.row * _piece.size;
			addChild(_piece);
			
			_piece.addEventListener(PieceEvent.PIECE_DROPPED, onPieceDropped);
			_piece.addEventListener(PieceEvent.PIECE_BROKEN, onPieceBroken);
		}
		
		public function removePiece(_piece:Piece):void
		{
			m_pieces.splice(m_pieces.indexOf(_piece), 1);
			removeChild(_piece);
			_piece.removeEventListener(PieceEvent.PIECE_DROPPED, onPieceDropped);
			_piece.removeEventListener(PieceEvent.PIECE_BROKEN, onPieceBroken);
			m_cells[_piece.row][_piece.column].piece = null;
		}
		
		public function dropPieces():void
		{
			m_dropper.dropPieces();
		}
		
		private function onPieceBroken(_event:PieceEvent):void
		{
			removePiece(_event.piece);
		}
		
		private function onPieceDropped(_event:PieceEvent):void
		{
			m_grouper.group(_event.piece);
		}
		
		private function onGroupCreated(_event:GroupEvent):void
		{
			m_groups.push(_event.group);
			m_breaker.add(_event.group);
			addChild(_event.group);
			_event.group.addEventListener(GroupEvent.GROUP_BROKEN, onGroupBroken);
			_event.group.addEventListener(GroupEvent.GROUP_UNGROUPED, onGroupUngrouped);
		}
		
		private function onGroupBroken(_event:GroupEvent):void
		{
			m_groups.splice(m_groups.indexOf(_event.group), 1);
			removeChild(_event.group);
			_event.group.removeEventListener(GroupEvent.GROUP_BROKEN, onGroupBroken);
		}
		
		private function onGroupUngrouped(_event:GroupEvent):void
		{
			m_groups.splice(m_groups.indexOf(_event.group), 1);
			removeChild(_event.group);
			_event.group.removeEventListener(GroupEvent.GROUP_UNGROUPED, onGroupUngrouped);
		}
		
		private function onGroupsBroken(_event:GroupsBrokenEvent):void
		{
			m_dropper.dropPieces();
			dispatchEvent(_event);
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
		
		public function get pieces():Vector.<Piece> 
		{
			return m_pieces;
		}
		
		public function toString():String
		{
			var str:String = "";
			for ( var row:int = 0; row < m_rows; row++) {
				for ( var column:int = 0; column < m_columns; column++) {
					if (cells[row][column].empty) {
						str += "0 ";
						
					} else {
						str += cells[row][column].piece.type.id + " ";
					}
				}
				str += "\n";
			}
			str += "\n";
			return str;
		}
	}
}