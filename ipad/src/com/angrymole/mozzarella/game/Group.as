package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.GroupEvent;
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
		private var m_tl:Piece;
		private var m_tr:Piece;
		private var m_bl:Piece;
		private var m_br:Piece;
		
		private var m_placeholder:Placeholder;
		
		private var m_touch:Touch;
		private var m_beginTouch:Touch;
		private var m_endTouch:Touch;
		
		public function Group(_tl:Piece, _tr:Piece, _bl:Piece, _br:Piece)
		{
			m_tl = _tl;
			m_tr = _tr;
			m_bl = _bl;
			m_br = _br;

			m_tl.visible = false;
			m_tr.visible = false;
			m_bl.visible = false;
			m_br.visible = false;
			
			m_placeholder = new Placeholder(_tl.size * 2, _tl.size * 2, _tl.type.color);
			addChild(m_placeholder);
			
			x = _tl.x;
			y = _tl.y;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		
		// FIXME: ASAP not working
		private function onTouch(_event:TouchEvent):void
		{
			m_touch = _event.getTouch(this);
			if ( m_touch == null ) { return; }
			
			if ( m_touch.phase == TouchPhase.BEGAN ) {
				m_beginTouch = m_touch;
				
			} else if ( m_touch.phase == TouchPhase.ENDED ) {
				m_endTouch = m_touch;
				dispatchEvent(new GroupEvent(GroupEvent.GROUP_BROKEN, this));
			}
		}
		
		public function get tl():Piece 
		{
			return m_tl;
		}
		
		public function get tr():Piece 
		{
			return m_tr;
		}
		
		public function get bl():Piece 
		{
			return m_bl;
		}
		
		public function get br():Piece 
		{
			return m_br;
		}
		
		public function get beginTouch():Touch 
		{
			return m_beginTouch;
		}
		
		public function get endTouch():Touch 
		{
			return m_endTouch;
		}
	}
}