package com.angrymole.mozzarella.game.grid 
{
	import com.angrymole.mozzarella.events.GroupEvent;
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.game.piece.Group;
	import com.angrymole.mozzarella.game.piece.Piece;
	import com.angrymole.mozzarella.game.piece.PieceType;
	import flash.geom.Point;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class GroupBreaker extends Sprite
	{
		private var m_grid:Grid;
		private var m_groups:Vector.<Group>;
		
		private var m_brokenGroups:Vector.<Group>;
		private var m_brokenPieces:int;
		private var m_centroid:Point;
		
		public function GroupBreaker(_grid:Grid) 
		{
			m_grid = _grid;
			m_groups = new Vector.<Group>();
		}
		
		public function add(_group:Group):void
		{
			_group.addEventListener(GroupEvent.GROUP_TOUCHED, onGroupTouched);
			_group.addEventListener(GroupEvent.GROUP_BROKEN, onGroupBroken);
			m_groups.push(_group);
		}
		
		private function remove(_group:Group):void
		{
			var idx:int = m_groups.indexOf(_group);
			if (idx < 0) { return; }
			
			m_groups.splice(idx, 1);
			_group.removeEventListener(GroupEvent.GROUP_TOUCHED, onGroupTouched);
			_group.removeEventListener(GroupEvent.GROUP_BROKEN, onGroupBroken);
		}
		
		private function onGroupTouched(_event:GroupEvent):void
		{
			m_brokenPieces = 0;
			m_centroid = new Point();
			m_brokenGroups = new Vector.<Group>();
			
			var type:PieceType = _event.group.tl.type;
			var stack:Vector.<Piece> = _event.group.pieces.concat();

			var piece:Piece;
			while (stack.length > 0) {
				piece = stack.pop();
				
				if (piece == null || !piece.grouped || !piece.type.equals(type)) { continue; }
					breakPiece(piece);
				
				if (piece.column > 0) {
					stack.push(m_grid.cells[piece.row][piece.column - 1].piece);
				}
					
				if (piece.column < m_grid.columns - 1) { 
					stack.push(m_grid.cells[piece.row][piece.column + 1].piece); 
				}
				
				if (piece.row > 0) { 
					stack.push(m_grid.cells[piece.row - 1][piece.column].piece);
				}
				
				if (piece.row < m_grid.rows - 1) {
					stack.push(m_grid.cells[piece.row + 1][piece.column].piece); 
				}
			}
			
			m_centroid.x /= m_brokenPieces;
			m_centroid.y /= m_brokenPieces;
			
			m_brokenGroups.sort(Group.compare);
			var i:int;
			for ( i = m_brokenGroups.length - 1; i > 0; --i ) {
				if (m_brokenGroups[i] === m_brokenGroups[i - 1]){
					m_brokenGroups.splice(i,1);
				}
			}
			
			for ( i = 0; i < m_brokenGroups.length; i++ ) {
				m_brokenGroups[i].broken();
			}
			
			dispatchEvent(new GroupsBrokenEvent(GroupsBrokenEvent.GROUPS_BROKEN, m_brokenPieces, m_brokenGroups.length, m_centroid));
		}
		
		private function breakPiece(_piece:Piece):void
		{
			// TODO: spawn some particles, and add them as the child
			// tween those particles, and remove the tween when done.
			
			// handle the match like adding score and stuff
			m_brokenPieces++;
			m_centroid.x += _piece.x;
			m_centroid.y += _piece.y;
			
			m_brokenGroups = m_brokenGroups.concat(_piece.groups);
			_piece.clearGroups();
			
			_piece.dispatchEvent(new PieceEvent(PieceEvent.PIECE_BROKEN, _piece));
		}
		
		private function onGroupBroken(_event:GroupEvent):void
		{
			remove(_event.group);
		}
	}

}