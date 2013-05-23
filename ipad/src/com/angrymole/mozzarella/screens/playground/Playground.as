package com.angrymole.mozzarella.screens.playground
{
	import com.angrymole.assets.Asset;
	import com.angrymole.assets.TextureAsset;
	import com.angrymole.assets.TextureAtlasAsset;
	import com.angrymole.mozzarella.events.GameOverEvent;
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.events.IntroEvent;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.events.PowerupEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.game.core.Configuration;
	import com.angrymole.mozzarella.game.grid.Grid;
	import com.angrymole.mozzarella.game.grid.Preview;
	import com.angrymole.mozzarella.game.powerups.Vacuum;
	import com.angrymole.mozzarella.game.ui.DropTrigger;
	import com.angrymole.mozzarella.game.ui.Intro;
	import com.angrymole.mozzarella.game.ui.Pause;
	import com.angrymole.mozzarella.game.ui.Score;
	import com.angrymole.mozzarella.game.ui.Spawner;
	import com.angrymole.mozzarella.game.ui.VaccumTrigger;
	import com.angrymole.mozzarella.gestures.GestureVisualizer;
	import com.angrymole.mozzarella.screens.Screen;
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
		private var m_intro:Intro;
		private var m_grid:Grid;
		private var m_spawner:Spawner;
		private var m_score:Score;
		private var m_pause:Pause;
		private var m_preview:Preview;
		private var m_vacuum:VaccumTrigger;
		private var m_drop:DropTrigger;
		
		public function Playground()
		{
			// FIXME: detect current level and load xml
			m_cfg = new Configuration(new XML());
			
			// TODO: implement assets list an loading
			m_assets = new Vector.<Asset>();
			m_assets.push(new TextureAsset("peluca_01", "/assets/peluca_01.png"));
			m_assets.push(new TextureAsset("peluca_02", "/assets/peluca_02.png"));
			m_assets.push(new TextureAsset("peluca_03", "/assets/peluca_03.png"));
			m_assets.push(new TextureAsset("peluca_05", "/assets/peluca_05.png"));
			m_assets.push(new TextureAsset("peluca_06", "/assets/peluca_06.png"));
			//m_assets.push(new TextureAtlasAsset("peluca_06", "/assets/peluca_06.png", "/assets/peluca_06.xml"));
		}
		
		override public function onLoad():void
		{
			m_grid = new Grid(m_cfg);
			m_grid.x = 160;
			m_grid.y = 60;
			
			m_preview = new Preview(m_grid);
			m_grid.addEventListener(GroupsBrokenEvent.GROUPS_BROKEN, m_preview.updateAll);
			m_grid.addEventListener(PowerupEvent.VACUUM, m_preview.updateAll);
			
			m_spawner = new Spawner(m_cfg);
			m_spawner.x = 160;
			m_spawner.y = 580;

			m_spawner.addEventListener(SpawnEvent.SPAWN_SWAPPABLE, m_preview.onPiecesSwappable);
			m_spawner.addEventListener(PieceEvent.PIECE_DRAGGED, m_preview.onPieceDragged);
			m_spawner.addEventListener(SpawnEvent.SPAWN_LOCKED, m_preview.onPiecesLocked);
			m_spawner.addEventListener(SpawnEvent.SPAWN_COMPLETE, m_grid.onSpawn);
			
			m_drop = new DropTrigger(m_spawner);
			m_drop. x = 832;
			m_drop.y = 580;
			m_spawner.addEventListener(SpawnEvent.SPAWN_STARTED, m_drop.onSpawnStarted);
			m_spawner.addEventListener(SpawnEvent.SPAWN_SWAPPABLE, m_drop.onSpawnSwappable);
			m_spawner.addEventListener(SpawnEvent.SPAWN_LOCKED, m_drop.onSpawnLocked);
			
			m_intro = new Intro();
			m_intro.addEventListener(IntroEvent.INTRO_COMPLETE, m_spawner.onIntroComplete);
			
			m_score = new Score(m_cfg);
			m_score.x = 64;
			m_score.y = 92;
			m_grid.addEventListener(GroupsBrokenEvent.GROUPS_BROKEN, m_score.onGroupsBroken);
			
			m_pause = new Pause();
			m_pause.x = 850;
			m_pause.y = 10;
			
			m_vacuum = new VaccumTrigger(m_score);
			m_vacuum.x = 870;
			m_vacuum.y = 410;
			m_vacuum.addEventListener(PowerupEvent.VACUUM, m_grid.onVacuum);
			
			addChild(m_spawner);
			addChild(m_grid);
			addChild(m_drop);
			addChild(m_preview);
			addChild(m_score);
			addChild(m_vacuum);
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
