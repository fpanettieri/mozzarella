package com.angrymole.mozzarella.game.ui 
{
	import com.angrymole.mozzarella.constants.Constants;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.game.core.Configuration;
	import com.angrymole.mozzarella.game.piece.Piece;
	import flash.geom.Point;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * Class used to handle the spawner input
	 * 
	 * @author Fabio Panettieri
	 */
	public class SpawnerInput extends Sprite
	{
		// used to allow fast play
		private const FUZZY_GRAB_DISTANCE:int = 64;
		private const TAP_DURATION:Number = 0.4;
		private const TAP_DISTANCE:Number = 24;
		
		private var m_spawner:Spawner;
		
		// configuration
		private var m_size:int;
		private var m_columns:int;
		private var m_hBuffer:Number;
		private var m_vBuffer:Number;
		
		// helper
		private var m_quad:Quad;
		private var m_minX:Number;
		private var m_maxX:Number;
		
		// inner state
		private var m_touch:Touch;
		private var m_touchPosition:Point;
		private var m_grabPosition:Point;
		private var m_grabTimestamp:Number;
		
		private var m_tapped:Piece;
		private var m_selected:Piece;
		
		public function SpawnerInput(_spawner:Spawner, _cfg:Configuration, _hBuffer:Number, _vBuffer:Number)
		{
			m_spawner = _spawner;
			
			m_size = _cfg.pieceSize;
			m_columns = _cfg.columns;
			
			m_minX = m_size / 2 - 2;
			m_maxX = (m_columns - 0.5) * m_size - Constants.GRABBED_MARGIN;
			
			m_touchPosition = new Point();
			m_grabPosition = new Point();
			
			m_tapped = null;
			m_selected = null;
			
			m_quad = new Quad(_spawner.width, _spawner.height + _vBuffer * 2, 0, true);
			m_quad.alpha = 0;
			m_quad.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(m_quad);
		}
		
		private function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(this);
			if (m_touch == null) { return; }
			
			m_touch.getLocation(m_quad, m_touchPosition);
			switch(m_touch.phase) {
				case TouchPhase.BEGAN: onTouchBegin(); break;
				case TouchPhase.MOVED: onTouchMove(); break;
				case TouchPhase.ENDED: onTouchEnd(); break;
			}
		}
		
		private function onTouchBegin():void
		{
			if (m_tapped != null) {
				m_spawner.swap(m_tapped.column, touchedColumn(), Constants.SWAP_TIME);
				m_selected = null;
				m_tapped = null;
				return;
			}
			
			m_grabPosition = m_touchPosition.clone();
			m_grabTimestamp = m_touch.timestamp;
			
			m_selected = m_spawner.pieces[fuzzyColumn()];
			if (m_selected == null) { return; }
			
			if (!m_selected.swappable) { 
				m_selected = null;
				return; 
			}
			
			m_selected.grab();
			m_spawner.dispatchEvent(new PieceEvent(PieceEvent.PIECE_UPDATED, m_selected));
		}
		
		private function onTouchMove():void
		{
			if (m_selected == null) { return; }
			
			if (m_touchPosition.x <= m_minX) {
				m_selected.x = -Constants.GRABBED_MARGIN;
			} else if (m_touchPosition.x >= m_maxX) {
				m_selected.x = m_maxX - m_size / 2;
			} else {
				m_selected.x = m_touchPosition.x - m_size / 2 - Constants.GRABBED_MARGIN;
			}
			
			m_spawner.dispatchEvent(new PieceEvent(PieceEvent.PIECE_UPDATED, m_selected));
		}
		
		private function onTouchEnd():void
		{
			if (m_selected == null) { return; }
			
			var column:int = touchedColumn();
			if (m_touch.timestamp - m_grabTimestamp > TAP_DURATION || 
				Math.abs(m_grabPosition.x - m_touchPosition.x) > TAP_DISTANCE) {
				m_spawner.swap(m_selected.column, column, Constants.SWAP_TIME);
				
			} else {
				m_tapped = m_selected;
				m_tapped.x = m_tapped.column * m_size - Constants.GRABBED_MARGIN;
			}
			m_selected == null;
		}
		
		public function lockPieces():void
		{
			m_tapped = null;
			m_selected = null;
		}
		
		private function touchedColumn():int
		{
			if (m_touchPosition.x <= m_minX) {
				return 0;
			} else if (m_touchPosition.x >= m_maxX) {
				return m_columns - 1;
			} else {
				return Math.floor(m_touchPosition.x / m_size);
			}
		}
		
		private function fuzzyColumn():int
		{
			var column:int = touchedColumn();
			var minDistance:int = int.MAX_VALUE;
			var distance:int;
			
			for ( var i:int = 0; i < m_spawner.pieces.length; i++) {
				if (m_spawner.pieces[i] == null) { continue; }
				
				distance = Math.abs(m_spawner.pieces[i].x + m_size / 2 - m_touchPosition.x);
				if (distance > FUZZY_GRAB_DISTANCE || distance >= minDistance) { continue; }
				
				minDistance = distance;
				column = m_spawner.pieces[i].column;
			}
			
			return column;
		}
	}

}