package com.angrymole.mozzarella.screens
{
	import com.angrymole.mozzarella.constants.PieceSize;
	import com.angrymole.mozzarella.events.GestureEvent;
	import com.angrymole.mozzarella.events.IntroEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.game.Configuration;
	import com.angrymole.mozzarella.game.Console;
	import com.angrymole.mozzarella.game.Grid;
	import com.angrymole.mozzarella.game.Intro;
	import com.angrymole.mozzarella.game.Score;
	import com.angrymole.mozzarella.game.Spawner;
	import com.angrymole.mozzarella.game.Swapper;
	import com.angrymole.mozzarella.game.Updater;
	import com.angrymole.mozzarella.gestures.GestureVisualizer;
	
	import com.angrymole.mozzarella.gestures.Gestures;
	
	/**
	 * An area where a single player can interact with the game
	 * 
	 * @author fpanettieri
	 */
	public class Playground extends Screen
	{
		// add 3, 2, 1, go object (Intro maybe?)
		private var m_cfg:Configuration;
		private var m_updater:Updater;
		private var m_intro:Intro;
		private var m_grid:Grid;
		private var m_spawner:Spawner;
		private var m_swapper:Swapper;
		private var m_gestures:Gestures;
		private var m_score:Score;
		private var m_console:Console;
		private var m_visualizer:GestureVisualizer;		
		
		public function Playground()
		{
			// FIXME: detect current level and load xml
			m_cfg = new Configuration(new XML());
			
			m_updater = new Updater();
			addChild(m_updater);
			
			m_intro = new Intro();
			addChild(m_intro);
			
			m_grid = new Grid(m_cfg);
			addChild(m_grid);
			
			m_spawner = new Spawner(m_cfg);
			addChild(m_spawner);
			m_intro.addEventListener(IntroEvent.INTRO_COMPLETE, m_spawner.onIntroComplete);
			
			m_gestures = new Gestures();
			addChild(m_gestures);
			m_gestures.addEventListener(GestureEvent.TAP_GESTURE, onGesture);
			m_gestures.addEventListener(GestureEvent.SWIPE_GESTURE, onGesture);
			m_gestures.addEventListener(GestureEvent.PATH_GESTURE, onGesture);
			
			m_swapper = new Swapper();
			addChild(m_swapper);
			
			m_score = new Score([50, 100, 200]);
			addChild(m_score);
			
			m_console = new Console(768, 512, "Console");
			addChild(m_console)
			
			m_visualizer = new GestureVisualizer();
			m_visualizer.touchable = false;
			addChild(m_visualizer);
			
			// TODO: create object that add pieces to the grid
			
			// position items
			m_grid.x = 56;
			m_grid.y = 84;			
			
			m_spawner.x = 56;
			m_spawner.y = 610;
			
			m_score.x = 850;
			m_score.y = 84;
			
			m_console.x = 56;
			m_console.y = 0;
			
			// register real time objects
			m_updater.register(m_spawner);
			m_updater.register(m_gestures);
		}
		
		private function onGesture(_e:GestureEvent):void
		{
			//m_console.debug(_e.gesture.toString());
			//m_visualizer.visualize(_e.gesture);
		}
	}
}
