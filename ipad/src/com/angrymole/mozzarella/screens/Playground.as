package com.angrymole.mozzarella.screens
{
	import com.angrymole.mozzarella.constants.PieceSize;
	import com.angrymole.mozzarella.events.GameOverEvent;
	import com.angrymole.mozzarella.events.GestureEvent;
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.events.IntroEvent;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.events.TimeTravelEvent;
	import com.angrymole.mozzarella.game.Configuration;
	import com.angrymole.mozzarella.game.Console;
	import com.angrymole.mozzarella.game.Grid;
	import com.angrymole.mozzarella.game.Intro;
	import com.angrymole.mozzarella.game.Pause;
	import com.angrymole.mozzarella.game.Preview;
	import com.angrymole.mozzarella.game.Score;
	import com.angrymole.mozzarella.game.Spawner;
	import com.angrymole.mozzarella.game.Updater;
	import com.angrymole.mozzarella.gestures.GestureVisualizer;
	import com.angrymole.mozzarella.util.Bounds;
	import flash.desktop.NativeApplication;
	import flash.geom.Point;
	import starling.events.TouchEvent;
	
	import com.angrymole.mozzarella.gestures.Gestures;
	
	/**
	 * An area where a single player can interact with the game
	 * It responsible of containing all the elements that can interact with the player.
	 * 
	 * It instantiates, and hard wire everything so the game works
	 * 
	 * @author fpanettieri
	 */
	public class Playground extends Screen
	{
		private var m_cfg:Configuration;
		private var m_updater:Updater;
		private var m_intro:Intro;
		private var m_grid:Grid;
		private var m_spawner:Spawner;
		private var m_score:Score;
		private var m_pause:Pause;
		private var m_console:Console;
		private var m_preview:Preview;
		
		public function Playground()
		{
			// FIXME: detect current level and load xml
			m_cfg = new Configuration(new XML());
			
			m_updater = new Updater();
			addChild(m_updater);
			
			m_grid = new Grid(m_cfg);
			m_grid.x = 56;
			m_grid.y = 84;
			
			m_preview = new Preview(m_grid);
			m_grid.addEventListener(GroupsBrokenEvent.GROUPS_BROKEN, m_preview.onGroupsBroken);
			m_grid.addEventListener(TimeTravelEvent.TIME_TRAVEL, m_preview.onTimeTravel);
			
			m_spawner = new Spawner(m_cfg);
			m_spawner.x = 56;
			m_spawner.y = 610;

			m_spawner.addEventListener(SpawnEvent.SPAWN_SWAPPABLE, m_preview.onPiecesSwappable);
			m_spawner.addEventListener(PieceEvent.PIECE_DRAGGED, m_preview.onPieceDragged);
			m_spawner.addEventListener(SpawnEvent.SPAWN_LOCKED, m_preview.onPiecesLocked);
			m_spawner.addEventListener(SpawnEvent.SPAWN_COMPLETE, m_grid.onSpawn);
			
			m_intro = new Intro();
			m_intro.addEventListener(IntroEvent.INTRO_COMPLETE, m_spawner.onIntroComplete);
			
			m_score = new Score(m_cfg);
			m_score.x = 850;
			m_score.y = 84;
			m_grid.addEventListener(GroupsBrokenEvent.GROUPS_BROKEN, m_score.onGroupsBroken);
			m_score.addEventListener(TimeTravelEvent.TIME_TRAVEL, m_grid.onTimeTravel);
			
			m_console = new Console(768, 512, "Console");
			m_console.x = 56;
			m_console.y = 0;

			m_pause = new Pause();
			m_pause.x = 850;
			m_pause.y = 10;
			
			addChild(m_console);
			addChild(m_spawner);
			addChild(m_grid);
			addChild(m_preview);
			addChild(m_score);
			addChild(m_intro);
			addChild(m_pause);
			
			m_grid.addEventListener(GameOverEvent.GAME_OVER, onGameOver);
		}
		
		private function onGameOver(_event:GameOverEvent):void
		{
			trace("Game over!");
			// NativeApplication.nativeApplication.exit();
		}
	}
}
