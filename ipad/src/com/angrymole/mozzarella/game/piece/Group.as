package com.angrymole.mozzarella.game.piece 
{
	import com.angrymole.mozzarella.events.GroupEvent;
	import com.angrymole.mozzarella.game.piece.Piece;
	import com.angrymole.mozzarella.util.Placeholder;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * A group of 4 pieces
	 * 
	 * @author Fabio Panettieri
	 */
	public class Group extends Sprite 
	{
		private var m_pieces:Vector.<Piece>;
		private var m_asset:PieceAsset;
		private var m_tween:Tween;
		
		
		// aux var used to detect the group touch
		private var m_touch:Touch;
		private var m_beginTouch:Touch;
		private var m_endTouch:Touch;
		
		public function Group(_tl:Piece, _tr:Piece, _bl:Piece, _br:Piece)
		{
			m_pieces = Vector.<Piece>([_tl, _tr, _bl, _br]);
			for (var i:int = 0; i < m_pieces.length; i++) {
				m_pieces[i].addGroup(this);
				
				// TODO: fade out pieces?
				m_pieces[i].visible = false;
			}
			
			m_asset = GroupAssetFactory.getAsset(_tl.type);
			addChild(m_asset.asset);
			
			x = _tl.x;
			y = _tl.y;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function push():void
		{
			var duration:Number = 0.1;
			var tween:Tween = new Tween(this, duration, Transitions.EASE_OUT_BOUNCE);
			tween.moveTo(x, y + m_pieces[0].size);
			queueTween(tween);
		}
		
		public function broken():void
		{
			// TODO: play break animation and dispatch the event on the callback
			dispatchEvent(new GroupEvent(GroupEvent.GROUP_BROKEN, this));
		}
		
		public function ungroup():void
		{
			// TODO: play ungroup animation
			for (var i:int = 0; i < m_pieces.length; i++) {
				m_pieces[i].removeGroup(this);
			}
			dispatchEvent(new GroupEvent(GroupEvent.GROUP_UNGROUPED, this));
		}
		
		private function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(this);
			if ( m_touch == null ) { return; }
			
			if ( m_touch.phase == TouchPhase.BEGAN ) {
				m_beginTouch = m_touch;
				
			} else if ( m_touch.phase == TouchPhase.ENDED ) {
				m_endTouch = m_touch;
				dispatchEvent(new GroupEvent(GroupEvent.GROUP_TOUCHED, this));
			}
		}
		
		private function queueTween(_tween:Tween):void
		{
			if (m_tween == null || m_tween.isComplete) {
				m_tween = _tween;
				Starling.juggler.add(m_tween);
			} else {
				m_tween.nextTween = _tween;
				m_tween = _tween;
			}
		}
		
		public function get pieces():Vector.<Piece> 
		{
			return m_pieces;
		}
		
		public function get tl():Piece 
		{
			return m_pieces[0];
		}
		
		public function get tr():Piece 
		{
			return m_pieces[1];
		}
		
		public function get bl():Piece 
		{
			return m_pieces[2];
		}
		
		public function get br():Piece 
		{
			return m_pieces[3];
		}
		
		public function get beginTouch():Touch 
		{
			return m_beginTouch;
		}
		
		public function get endTouch():Touch 
		{
			return m_endTouch;
		}
		
		public static function compare(x:Group, y:Group):Number
		{
			if (x === y) 					{ return 0; }
			if (x.tl.row < y.tl.row) 		{ return -1; }
			if (x.tl.column < y.tl.column) 	{ return -1; }
			if (x.tl.row > y.tl.row) 		{ return 1; }
			if (x.tl.column > y.tl.column) 	{ return 1; }
			return 0;
		}
	}
}