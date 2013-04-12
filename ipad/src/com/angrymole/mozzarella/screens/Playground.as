package com.angrymole.mozzarella.screens
{
	import com.angrymole.mozzarella.constants.PieceSize;
	import com.angrymole.mozzarella.events.GameOverEvent;
	import com.angrymole.mozzarella.events.GestureEvent;
	import com.angrymole.mozzarella.events.IntroEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.game.Configuration;
	import com.angrymole.mozzarella.game.Console;
	import com.angrymole.mozzarella.game.Grid;
	import com.angrymole.mozzarella.game.Interpreter;
	import com.angrymole.mozzarella.game.Intro;
	import com.angrymole.mozzarella.game.Pause;
	import com.angrymole.mozzarella.game.Score;
	import com.angrymole.mozzarella.game.Spawner;
	import com.angrymole.mozzarella.game.Updater;
	import com.angrymole.mozzarella.gestures.GestureVisualizer;
	import flash.desktop.NativeApplication;
	
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
		private var m_gestures:Gestures;
		private var m_visualizer:GestureVisualizer;
		private var m_interpreter:Interpreter;
		
		public function Playground()
		{
			// FIXME: detect current level and load xml
			m_cfg = new Configuration(new XML());
			
			m_updater = new Updater();
			addChild(m_updater);
			
			m_intro = new Intro();
			
			m_grid = new Grid(m_cfg);
			m_grid.x = 56;
			m_grid.y = 84;
			
			m_spawner = new Spawner(m_cfg);
			m_spawner.x = 56;
			m_spawner.y = 610;
			m_intro.addEventListener(IntroEvent.INTRO_COMPLETE, m_spawner.onIntroComplete);
			m_spawner.addEventListener(SpawnEvent.SPAWN_COMPLETE, m_grid.onSpawn);
			
			m_console = new Console(768, 512, "Console");
			m_console.x = 56;
			m_console.y = 0;
			
			// Input handling
			m_gestures = new Gestures();
			
			m_interpreter = new Interpreter();
			m_gestures.addEventListener(GestureEvent.TAP_GESTURE, m_interpreter.onTap);
			m_gestures.addEventListener(GestureEvent.SWIPE_GESTURE, m_interpreter.onSwipe);
			m_interpreter.grid = m_grid;
			m_interpreter.spawner = m_spawner;
			
			m_score = new Score([50, 100, 200]);
			m_score.x = 850;
			m_score.y = 84;
			
			m_pause = new Pause();
			m_pause.x = 850;
			m_pause.y = 10;
			
			addChild(m_console);
			addChild(m_spawner);
			addChild(m_grid);
			addChild(m_score);
			addChild(m_intro);
			addChild(m_pause);
			addChild(m_gestures);
			
			m_grid.addEventListener(GameOverEvent.GAME_OVER, onGameOver);
			
			// register real time objects
			//m_updater.register(m_grid);
		}
		
		private function onGameOver(_event:GameOverEvent):void
		{
			trace("Game over!");
			NativeApplication.nativeApplication.exit();
		}
	}
}
