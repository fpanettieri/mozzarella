package com.angrymole.mozzarella.screens.playground
{
	import com.angrymole.assets.Asset;
	import com.angrymole.assets.AtfAsset;
	import com.angrymole.assets.DragonbonesAsset;
	import com.angrymole.assets.TextureAsset;
	import com.angrymole.assets.TextureAtlasAsset;
	import com.angrymole.assets.XMLAsset;
	import com.angrymole.mozzarella.events.GameOverEvent;
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.events.IntroEvent;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.events.VacuumEvent;
	import com.angrymole.mozzarella.game.core.Configuration;
	import com.angrymole.mozzarella.game.grid.Grid;
	import com.angrymole.mozzarella.game.grid.Preview;
	import com.angrymole.mozzarella.game.layout.Background;
	import com.angrymole.mozzarella.game.powerups.Vacuum;
	import com.angrymole.mozzarella.game.score.HardScore;
	import com.angrymole.mozzarella.game.score.Score;
	import com.angrymole.mozzarella.game.score.SoftScore;
	import com.angrymole.mozzarella.game.time.Clock;
	import com.angrymole.mozzarella.game.time.Timer;
	import com.angrymole.mozzarella.game.ui.Intro;
	import com.angrymole.mozzarella.game.ui.Pause;
	import com.angrymole.mozzarella.game.ui.Spawner;
	import com.angrymole.mozzarella.game.ui.SpawnTrigger;
	import com.angrymole.mozzarella.game.ui.SpawnTrigger;
	import com.angrymole.mozzarella.game.ui.VacuumTrigger;
	import com.angrymole.mozzarella.gestures.GestureVisualizer;
	import com.angrymole.mozzarella.screens.Screen;
	import com.angrymole.mozzarella.util.Bounds;
	import com.angrymole.mozzarella.util.CustomTransitions;
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
		private var m_background:Background;
		private var m_intro:Intro;
		private var m_grid:Grid;
		private var m_spawner:Spawner;
		private var m_spawnTrigger:SpawnTrigger;
		private var m_score:Score;
		private var m_softScore:SoftScore;
		private var m_hardScore:HardScore;
		private var m_pause:Pause;
		private var m_preview:Preview;
		private var m_vacuum:Vacuum;
		private var m_vacuumTrigger:VacuumTrigger;
		private var m_timer:Timer;
		
		public function Playground()
		{
			CustomTransitions.register();
			
			m_assets.push(new AtfAsset("background", "/assets/bg_01.atf"));
			m_assets.push(new DragonbonesAsset("layout", "/assets/layout.dbg"));
			m_assets.push(new XMLAsset("level", "/levels/level01.oel"));
			m_assets.push(new TextureAtlasAsset("pelucas", "/assets/pelucas.png", "/assets/pelucas.xml"));
		}
		
		override public function onLoad():void
		{
			m_cfg = new Configuration();
			m_background = new Background();
			
			m_grid = new Grid(m_cfg);
			m_grid.x = 182;
			m_grid.y = 94;
			
			m_preview = new Preview(m_grid);
			m_grid.addEventListener(GroupsBrokenEvent.GROUPS_BROKEN, m_preview.updateAll);
			
			m_spawner = new Spawner(m_cfg);
			m_spawner.x = 182;
			m_spawner.y = 625;
			
			m_spawner.addEventListener(SpawnEvent.SPAWN_SWAPPABLE, m_preview.onPiecesSwappable);
			m_spawner.addEventListener(SpawnEvent.SPAWN_SWAPPABLE, m_preview.onPiecesSwappable);
			m_spawner.addEventListener(PieceEvent.PIECE_DRAGGED, m_preview.onPieceDragged);
			m_spawner.addEventListener(SpawnEvent.SPAWN_LOCKED, m_preview.onPiecesLocked);
			m_spawner.addEventListener(SpawnEvent.SPAWN_COMPLETE, m_grid.onSpawn);
			
			m_spawnTrigger = new SpawnTrigger();
			m_spawnTrigger. x = 832;
			m_spawnTrigger.y = 580;
			m_spawnTrigger.addEventListener(SpawnEvent.SPAWN_TRIGGER, m_spawner.onSpawnTrigger);
			m_spawner.addEventListener(SpawnEvent.SPAWN_SWAPPABLE, m_spawnTrigger.onSpawnSwappable);
			m_spawner.addEventListener(SpawnEvent.SPAWN_LOCKED, m_spawnTrigger.onSpawnLocked);
			
			m_intro = new Intro();
			m_intro.addEventListener(IntroEvent.INTRO_COMPLETE, m_spawner.onIntroComplete);
			
			m_score = new Score(m_cfg);
			m_grid.addEventListener(GroupsBrokenEvent.GROUPS_BROKEN, m_score.onGroupsBroken);
			
			m_softScore = new SoftScore(m_score);
			m_softScore.x = 10;
			m_softScore.y = 92;
			
			m_hardScore = new HardScore(m_score);
			m_hardScore.x = 650;
			m_hardScore.y = 20;
			
			m_pause = new Pause();
			m_pause.x = 850;
			m_pause.y = 10;
			
			m_vacuum = new Vacuum(m_grid, m_score);
			m_vacuum.addEventListener(VacuumEvent.VACUUM_COMPLETE, m_preview.updateAll);
			m_vacuum.addEventListener(VacuumEvent.VACUUM_STARTED, m_spawner.onPause);
			m_vacuum.addEventListener(VacuumEvent.VACUUM_COMPLETE, m_spawner.onResume);
			
			m_vacuumTrigger = new VacuumTrigger();
			m_vacuumTrigger.x = 935;
			m_vacuumTrigger.y = 280;
			m_vacuumTrigger.addEventListener(VacuumEvent.VACUUM_TRIGGER, m_vacuum.onVacuumTrigger);
			m_spawner.addEventListener(SpawnEvent.SPAWN_SWAPPABLE, m_vacuumTrigger.onSpawnSwappable);
			m_spawner.addEventListener(SpawnEvent.SPAWN_LOCKED, m_vacuumTrigger.onSpawnLocked);
			
			m_timer = new Clock();
			m_timer.x = 70;
			m_timer.y = 20;
			m_timer.addEventListener(GameOverEvent.GAME_OVER, onGameOver);
			m_intro.addEventListener(IntroEvent.INTRO_COMPLETE, m_timer.onIntroComplete);
			
			addChild(m_background);
			addChild(m_spawner);
			addChild(m_spawnTrigger);
			addChild(m_grid);
			addChild(m_preview);
			addChild(m_softScore);
			addChild(m_hardScore);
			addChild(m_timer);
			addChild(m_vacuum);
			addChild(m_vacuumTrigger);
			addChild(m_intro);
			//addChild(m_pause);
			
			m_grid.addEventListener(GameOverEvent.GAME_OVER, onGameOver);
		}
		
		private function onGameOver(_event:GameOverEvent):void
		{
			trace("Game over!");
			NativeApplication.nativeApplication.exit();
		}
	}
}
