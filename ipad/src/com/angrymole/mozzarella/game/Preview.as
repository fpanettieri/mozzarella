package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import starling.display.Sprite;
	
	/**
	 * Used to display the preview of a piece
	 * @author Fabio Panettieri
	 */
	public class Preview extends Sprite
	{
		private var m_grid:Grid;
		private var m_pieces:Vector.<Piece>;
		private var m_previews:Vector.<PiecePreview>;
		
		public function Preview(_grid:Grid) 
		{
			m_grid = _grid;
			m_pieces = new Vector.<Piece>();
			m_previews = new Vector.<PiecePreview>();
		}
		
		public function onPiecesSwappable(_e:SpawnEvent):void
		{
			for each(var piece:Piece in _e.pieces) {
				if (piece == null) { continue; }
				add(piece);
			}
		}
		
		public function onPieceDragged(_e:PieceEvent):void
		{
			update(_e.piece);
		}
		
		public function onPiecesLocked(_e:SpawnEvent):void
		{
			clear();
		}
		
		public function onGroupsBroken(_e:GroupsBrokenEvent):void
		{
			for ( var i:int = 0; i < m_pieces.length; i++) {
				update(m_pieces[i]);
			}
		}
		
		private function add(_piece:Piece):void
		{
			if (m_pieces.indexOf(_piece) > -1) {
				throw new Error("Piece already previewed");
			}
			m_pieces.push(_piece);
			
			var preview:PiecePreview = new PiecePreview(_piece);
			m_previews.push( preview );
			preview.update(m_grid);
			addChild(preview);
		}
		
		private function update(_piece:Piece):void
		{
			var pos:int = m_pieces.indexOf(_piece);
			if (pos < 0) {
				throw new Error("Piece not previewed");
			}
			m_previews[pos].update(m_grid);
		}
		
		private function remove(_piece:Piece):void
		{
			var pos:int = m_pieces.indexOf(_piece);
			if (pos < 0) {
				throw new Error("Piece not previewed");
			}
			removeChild(m_previews[pos]);
			m_previews.splice(pos, 1);
			m_pieces.splice(pos, 1);
		}
		
		private function clear():void
		{
			removeChildren();
			m_previews.length = 0;
			m_pieces.length = 0;
		}
	}
}