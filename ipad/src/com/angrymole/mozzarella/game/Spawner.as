package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.IntroEvent;
	import starling.display.Sprite;
	
	/**
	 * It randomly spawn pieces that can be swaped before they are thrown into the grid.
	 * 
	 * columns: how many columns this grid has
	 * colors: array of possible colors
	 * min: the minimum number of pieces that can spawn on each iteration
	 * progession: array indicating how many iterations should pass until the number of spawns is increased
	 * interval: how many miliseconds pass between each spawn iteration
	 * elapsed: elapsed time since the last spawn
	 * 
	 * @author Fabio Panettieri
	 */
	public class Spawner extends Sprite 
	{
		private var m_columns:int;
		private var m_types:Array;
		private var m_min:int;
		private var m_max:int;
		private var m_progression:Array;
		private var m_interval:Number;
		private var m_elapsed:Number;
		
		private var m_placeholder:Placeholder;
		
		public function Spawner(_cfg:Configuration)
		{
			m_columns = _cfg.columns;
			m_types = _cfg.pieceTypes;
			m_min = _cfg.spawnMin;
			m_max = _cfg.spawnMax;
			m_progression = _cfg.spawnProgression;
			m_interval = _cfg.spawnInterval;
			m_elapsed = 0;
			
			m_placeholder = new Placeholder(_cfg.columns * _cfg.pieceSize, _cfg.pieceSize, 0xff303030);
			addChild(m_placeholder);
		}
		
		public function onIntroComplete(_event:IntroEvent):void
		{
			trace("start the spawn process :D");
		}
	}
}