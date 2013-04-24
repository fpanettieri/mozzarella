package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.GroupEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import starling.display.Sprite;
	
	/**
	 * Build group of pieces when 4 pieces 
	 * are next to each other in the grid
	 * 
	 * @author Fabio Panettieri
	 */
	public class GroupBreaker extends Sprite
	{
		private var m_grid:Grid;
		private var m_groups:Vector.<Group>;
		
		// aux vars
		private var m_touch:Touch;
		private var m_target:Group;
		
		private var m_beginTouch:Touch;
		private var m_beginTarget:Group;
		
		private var m_endTouch:Touch;
		private var m_endTarget:Group;
		
		public function GroupBreaker(_grid:Grid) 
		{
			m_grid = _grid;
			m_groups = new Vector.<Group>();
		}
		
		public function add(_group:Group):void
		{
			m_groups.push(_group);
			_group.addEventListener(TouchEvent.TOUCH, onGroupTouch);
		}
		
		// FIXME: ASAP not working
		private function onGroupTouch(_event:TouchEvent):void
		{
			m_target = _event.target as Group;
			m_touch = _event.getTouch(m_target);
			if ( m_touch == null ) { return; }
			
			if ( m_touch.phase == TouchPhase.BEGAN ) {
				m_beginTouch = m_touch;
				m_beginTarget = m_target;
				
			} else if ( m_touch.phase == TouchPhase.ENDED ) {
				m_endTouch = m_touch;
				m_endTarget = m_target;
				
				if ( m_beginTarget != m_endTarget ) {
					clear();
				} else {
					breakGroup();
				}
			}
		}
		
		private function clear():void
		{
			m_beginTarget = null;
			m_beginTouch = null;
			m_endTouch = null;
			m_endTouch = null;
		}
		
		private function breakGroup():void
		{
			trace("breaking group!");
			// TODO: detect direction
			// spawn particles
			// dispatch a group event
			// the grid should listen to that event and play the group break animation and remove it as his child when its done
			clear();
		}
	}
}