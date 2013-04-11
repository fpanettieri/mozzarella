package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.GestureEvent;
	import com.angrymole.mozzarella.gestures.Swipe;
	import com.angrymole.mozzarella.gestures.Tap;
	import com.angrymole.mozzarella.util.Bounds;
	import flash.geom.Point;
	
	/**
	 * This class parses gestures and call the apropiate methods
	 * 
	 * @author Fabio Panettieri
	 */
	public class Interpreter 
	{
		private var m_grid:Grid;
		private var m_gridBounds:Bounds;
		
		private var m_spawner:Spawner;
		private var m_spawnerBounds:Bounds;
		
		public function onTap(_e:GestureEvent):void
		{
			var tap:Tap = _e.gesture as Tap;
			
			if (m_gridBounds.contains(_e.gesture.begin)) {
				m_grid.push(tap.x - m_gridBounds.minX, tap.y - m_gridBounds.minY);
			
			} else if (m_spawnerBounds.contains(tap.begin)) {
				m_spawner.select(tap.x - m_spawnerBounds.minX);
			}
		}
		
		public function onSwipe(_e:GestureEvent):void
		{
			var swipe:Swipe = _e.gesture as Swipe;
			if (m_spawnerBounds.contains(swipe.begin) && m_gridBounds.contains(swipe.end) && m_spawner.areAllSwappable()) {
				m_spawner.spawnComplete();
				
			} else if (m_spawnerBounds.contains(swipe.begin) && m_spawnerBounds.contains(swipe.end)) {
				m_spawner.swap(swipe.begin.x - m_spawnerBounds.minX, swipe.end.x - m_spawnerBounds.minX);
			
			} else if (m_gridBounds.contains(swipe.begin)) {
				m_grid.slash(swipe.begin, swipe.end, swipe.direction, Point.distance(swipe.begin, swipe.end) / swipe.duration);
			}
		}
		
		public function set grid(value:Grid):void 
		{
			m_grid = value;
			m_gridBounds = new Bounds(new Point(value.x, value.y), new Point(value.x + value.width, value.y + value.height));
		}
		
		public function set spawner(value:Spawner):void 
		{
			m_spawner = value;
			m_spawnerBounds = new Bounds(new Point(value.x, value.y), new Point(value.x + value.width, value.y + value.height));
		}		
	}

}