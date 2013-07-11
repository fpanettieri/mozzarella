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
		
		private var m_brokenPieces:Vector.<Piece> 
		private var m_brokenGroups:Vector.<Group>;
		private var m_brokenPiecesCount:int;
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
			m_brokenPieces = _event.group.pieces;
			for (var i:int = 0; i < m_brokenPieces.length; i++) {
				breakPiece(m_brokenPieces[i]);
			}
			m_centroid = new Point(_event.group.x + _event.group.width / 2, _event.group.y + _event.group.height / 2);
			_event.group.broken();
			
			dispatchEvent( new GroupsBrokenEvent( GroupsBrokenEvent.GROUPS_BROKEN, m_brokenPieces.length, 1, m_centroid, m_brokenPieces[0].type ));
		}
		
		private function breakPiece(_piece:Piece):void
		{
			// TODO: spawn some particles, and add them as the child
			// tween those particles, and remove the tween when done.
			
			_piece.clearGroups();
			_piece.dispatchEvent(new PieceEvent(PieceEvent.PIECE_BROKEN, _piece));
		}
		
		private function onGroupBroken(_event:GroupEvent):void
		{
			remove(_event.group);
		}
	}

}