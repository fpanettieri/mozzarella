package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.PieceEvent;
	import flash.geom.Point;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * Class used to handle the spawner input
	 * 
	 * @author Fabio Panettieri
	 */
	public class SpawnerInput 
	{
		private var m_spawner:Spawner;
		
		// configuration
		private var m_size:int;
		private var m_columns:int;
		
		// helper
		private var m_minX:Number;
		private var m_maxX:Number;
		
		// inner state
		private var m_touched:Boolean;
		private var m_touch:Touch;
		private var m_touchPosition:Point;
		private var m_touchedColumn:Number;
		private var m_previousPosition:Point;
		
		private var m_selected:Piece;
		
		public function SpawnerInput(_spawner:Spawner, _cfg:Configuration)
		{
			m_spawner = _spawner;
			
			m_size = _cfg.pieceSize;
			m_columns = _cfg.columns;
			
			m_minX = m_size / 2 - 2;
			m_maxX = (m_columns - 0.5) * m_size - 6;
			
			m_touched = false;
			m_touchPosition = new Point();
			m_previousPosition = new Point();
		}
		
		public function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(m_spawner);
			if (m_touch == null) { return; }
			
			m_touch.getLocation(m_spawner, m_touchPosition);
			switch(m_touch.phase) {
				case TouchPhase.BEGAN: grabPiece(); break;
				case TouchPhase.MOVED: dragPiece(); break;
				case TouchPhase.ENDED: dropPiece(); break;
			}
		}
		
		private function grabPiece():void
		{
			m_touchedColumn = Math.floor( m_touchPosition.x / m_size );
			m_selected = m_spawner.pieces[m_touchedColumn];
			m_touched = true;
			
			if (m_selected == null) { return; }
			if (!m_selected.swappable) { 
				m_selected = null;
				return; 
			}
			
			m_selected = m_spawner.pieces[m_touchedColumn];
			m_selected.select();
		}
		
		private function dragPiece():void
		{
			if (m_touched && m_touchPosition.y < -48) {
				m_spawner.lockPieces();
				m_touched = false;
			}
			
			if (m_selected == null) { return; }

			if (m_touchPosition.x <= m_minX) {
				m_selected.x = -6;
			} else if (m_touchPosition.x >= m_maxX) {
				m_selected.x = m_maxX - m_size / 2;
			} else {
				m_selected.x = m_touchPosition.x - m_size / 2 - 6;
			}
			
			m_spawner.dispatchEvent(new PieceEvent(PieceEvent.PIECE_DRAGGED, m_selected));
		}
		
		private function dropPiece():void
		{
			m_touched = false;
			if (m_selected == null) { return; }
			
			if (m_touchPosition.x <= m_minX) {
				m_touchedColumn = 0;
			} else if (m_touchPosition.x >= m_maxX) {
				m_touchedColumn = m_columns - 1;
			} else {
				m_touchedColumn = Math.floor(m_touchPosition.x / m_size);
			}
			
			m_spawner.swap(m_selected.column, m_touchedColumn);
			m_selected == null;
		}
		
		public function lockPieces():void
		{
			if (m_selected == null) { return; }
			m_selected.unselect();
			m_selected = null;
		}
	}

}