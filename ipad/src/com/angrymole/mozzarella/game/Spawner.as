package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.IntroEvent;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * It randomly spawn pieces that can be swaped before they are thrown into the grid.
	 * 
	 * juggler: used
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
		private var m_delay:Number;		
		
		private var m_juggler:Juggler;
		private var m_placeholder:Placeholder;
		
		public function Spawner(_cfg:Configuration)
		{
			m_columns = _cfg.columns;
			m_types = _cfg.pieceTypes;
			m_min = _cfg.spawnMin;
			m_max = _cfg.spawnMax;
			m_progression = _cfg.spawnProgression;
			m_delay = _cfg.spawnDelay;
			
			m_juggler = new Juggler();
			addEventListener(Event.ENTER_FRAME, onFrame);
			
			m_placeholder = new Placeholder(_cfg.columns * _cfg.pieceSize, _cfg.pieceSize, 0xff303030);
			addChild(m_placeholder);
		}
		
		public function onIntroComplete(_event:IntroEvent):void
		{
			spawnPieces();
		}
		
		private function onFrame(_event:EnterFrameEvent):void
		{
			m_juggler.advanceTime(_event.passedTime);
		}
		
		private function spawnPieces():void
		{
			// TODO: do some magic and spawn a groupd of swapable pieces;
			trace("spawning pieces");
			
			m_juggler.delayCall(spawnPieces, m_delay);
		}
	}
}