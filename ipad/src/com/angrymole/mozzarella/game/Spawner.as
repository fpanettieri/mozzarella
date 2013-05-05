package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.IntroEvent;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.interfaces.IUpdatable;
	import flash.geom.Point;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * It randomly spawn pieces that can be swaped before they are thrown into the grid.
	 * 
	 * juggler: used
	 * columns: how many columns this grid has
	 * colors: array of possible colors
	 * min: the minimum number of pieces that can spawn on each iteration
	 * current: the number of pieces that will spawn on the next iteration
	 * max: the maximum number of pieces that can spawn on each iteration
	 * progession: array indicating how many iterations should pass until the number of spawns is increased
	 * interval: how many miliseconds pass between each spawn iteration
	 * elapsed: elapsed time since the last spawn
	 * 
	 * @author Fabio Panettieri
	 */
	public class Spawner extends Sprite
	{
		private var m_size:int;
		private var m_columns:int;
		private var m_types:Vector.<PieceType>;
		private var m_iterations:Vector.<int>;
		private var m_progression:Vector.<int>;
		private var m_spawnLife:Vector.<int>;
		private var m_swapTime:Number;
		private var m_iteration:int;
		private var m_globalIteration:int;
		
		private var m_pieceId:int;
		private var m_spawnedPieces:int;
		private var m_delayedCall:DelayedCall;
		
		private var m_placeholder:Placeholder;
		private var m_pieces:Vector.<Piece>;
		
		private var m_input:SpawnerInput;
		
		public function Spawner(_cfg:Configuration)
		{
			m_size = _cfg.pieceSize;
			m_columns = _cfg.columns;
			m_types = _cfg.pieceTypes;
			m_iterations = _cfg.spawnIterations;
			m_progression = _cfg.spawnProgression;
			m_spawnLife = _cfg.spawnLife;
			m_swapTime = _cfg.swapTime;
			m_iteration = 0;
			m_globalIteration = 0;
			
			m_placeholder = new Placeholder(_cfg.columns * _cfg.pieceSize, _cfg.pieceSize, 0x584E4B);
			addChild(m_placeholder);
			
			m_pieces = new Vector.<Piece>(m_columns);
			m_spawnedPieces = 0;
			
			m_input = new SpawnerInput(this, _cfg);
			addEventListener(TouchEvent.TOUCH, m_input.onTouch);
		}
		
		// Called when the 3,2,1 go animation has completed
		public function onIntroComplete(_event:IntroEvent):void
		{
			spawnPieces();
		}
		
		public function swap(_from:int, _to:int, _duration:Number):void
		{
			var from:Piece = m_pieces[_from];
			var to:Piece = m_pieces[_to];
			
			m_pieces[_from] = to;
			m_pieces[_to] = from;
			
			if (from != null) {
				from.swap(_to, _duration);
				from.parent.setChildIndex(from, from.parent.numChildren - 1);
			}
			
			if (to != null) {
				to.swap(_from, _duration);
				to.parent.setChildIndex(to, to.parent.numChildren - 2);
			}
		}
		
		// Spawn a new set of pieces
		private function spawnPieces():void
		{
			dispatchEvent(new SpawnEvent(SpawnEvent.SPAWN_STARTED));
			
			var i:int;
			var emptyColumns:Vector.<int> = new Vector.<int>();
			for (i = 0; i < m_columns; i++) { emptyColumns.push(i); }
			
			var idx:int;
			var column:int;
			var type:PieceType;
			var piece:Piece;
			
			var pieceCount:int = m_progression[0];
			for (i = 0; i < pieceCount; i++) {
				type = m_types[ Math.floor( Math.random() * m_types.length ) ];
				
				idx = Math.floor( Math.random() * emptyColumns.length )
				column = emptyColumns[idx];
				emptyColumns.splice(idx, 1);
				
				// TODO: check if the row has to change in the future if we support multiple spawn positions
				piece = new Piece(++m_pieceId, -1, column, type, m_size, m_globalIteration);
				piece.x = column * m_size;
				piece.y = 100 + Math.random() * 10;
				piece.addEventListener(SpawnEvent.SPAWN_PIECE, onPieceSpawn);
				piece.touchable = false;
				piece.intro();
				
				m_pieces[column] = piece;
				addChild(piece);
				
				m_spawnedPieces++;
			}
			
			if ( m_iterations.length > 0 && m_iteration == m_iterations[0]) {
				m_iterations.shift();
				m_progression.shift();
				m_spawnLife.shift();
				m_iteration = 0;
			} else {
				m_iteration++;
			}
			m_globalIteration++;
		}
		
		private function onPieceSpawn(_event:SpawnEvent):void
		{
			m_spawnedPieces--;
			if (m_spawnedPieces > 0) { return; }
			dispatchEvent(new SpawnEvent(SpawnEvent.SPAWN_SWAPPABLE, m_pieces));
			m_delayedCall = Starling.juggler.delayCall(lockPieces, m_spawnLife[0]);
		}
		
		public function lockPieces():void
		{
			Starling.juggler.remove(m_delayedCall);
			for (var i:int = 0 ; i < m_pieces.length; i++) {
				if (m_pieces[i] == null) { continue; }
				m_pieces[i].swappable = false;
				
				// TODO: animate jump preparation
			}
			m_input.lockPieces();
			dispatchEvent(new SpawnEvent(SpawnEvent.SPAWN_LOCKED, m_pieces));
			m_delayedCall = Starling.juggler.delayCall(spawnComplete, m_swapTime);
		}
		
		private function spawnComplete():void
		{
			Starling.juggler.remove(m_delayedCall);
			dispatchEvent(new SpawnEvent(SpawnEvent.SPAWN_COMPLETE, m_pieces));
			removePieces();
			m_delayedCall = Starling.juggler.delayCall(spawnPieces, 0.5);
		}
		
		private function removePieces():void
		{
			for (var i:int = 0 ; i < m_pieces.length; i++) {
				if (m_pieces[i] == null) { continue; }
				removeChild( m_pieces[i] );
				m_pieces[i] = null;
			}
		}
		
		public function get pieces():Vector.<Piece> 
		{
			return m_pieces;
		}
	}
}