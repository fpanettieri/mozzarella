package com.angrymole.mozzarella.game.grid 
{
	import com.angrymole.mozzarella.events.MozzarellaEvent;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class GridDebugger 
	{
		private var m_grid:Grid;
		
		public function GridDebugger(_grid:Grid) 
		{
			m_grid = _grid;
		}
		
		public function onEvent(_event:MozzarellaEvent):void
		{
			trace(_event.type + "\n" + m_grid);
			trace("\n");
		}
	}
}