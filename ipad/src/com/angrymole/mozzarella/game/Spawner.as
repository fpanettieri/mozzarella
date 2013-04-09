package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.IntroEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.interfaces.IUpdatable;
	import flash.geom.Point;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Sprite;
	
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
		private var m_delay:Number;
		private var m_iteration:int;
		
		private var m_delayedCall:DelayedCall;
		
		private var m_placeholder:Placeholder;
		private var m_pieces:Vector.<Piece>;
		private var m_selected:int;
		
		public function Spawner(_cfg:Configuration)
		{
			m_size = _cfg.pieceSize;
			m_columns = _cfg.columns;
			m_types = _cfg.pieceTypes;
			m_iterations = _cfg.spawnIterations;
			m_progression = _cfg.spawnProgression;
			m_delay = _cfg.spawnDelay;
			m_iteration = 0;
			m_selected = -1;
			
			m_placeholder = new Placeholder(_cfg.columns * _cfg.pieceSize, _cfg.pieceSize, 0xC45A3B);
			addChild(m_placeholder);
			
			m_pieces = new Vector.<Piece>(m_columns);
		}
		
		public function onIntroComplete(_event:IntroEvent):void
		{
			spawnPieces();
		}
		
		public function removePieces():void
		{
			for (var i:int = 0 ; i < m_pieces.length; i++) {
				if (m_pieces[i] == null) { continue; }
				removeChild( m_pieces[i] );
				m_pieces[i] = null;
			}
		}
		
		public function spawnPieces():void
		{
			dispatchEvent(new SpawnEvent(SpawnEvent.SPAWN_STARTED));
			
			if ( m_delayedCall ) {
				Starling.juggler.remove(m_delayedCall);
			}
			
			// TODO: when piece spawn start, add all pieces to the grid
			removePieces();
			
			var i:int;
			var emptyColumns:Vector.<int> = new Vector.<int>();
			for (i = 0; i < m_columns; i++) { emptyColumns.push(i); }
			
			var idx:int;
			var column:int;
			var row:int;
			var type:PieceType;
			var piece:Piece;
			
			var pieceCount:int = m_progression[0];
			for (i = 0; i < pieceCount; i++) {
				type = m_types[ Math.floor( Math.random() * m_types.length ) ];
				
				idx = Math.floor( Math.random() * emptyColumns.length )
				column = emptyColumns[idx];
				emptyColumns.splice(idx, 1);
				
				// FIXME: check if the row has to change in the future if we support multiple spawn positions
				row = -1;
				piece = new Piece(row, column, type, m_size, true);
				piece.x = column * m_size;
				
				m_pieces[column] = piece;
				addChild(piece);
			}
			
			if ( m_iterations.length > 0 && m_iteration == m_iterations[0]) {
				m_iterations.shift();
				m_progression.shift();
				m_iteration = 0;
			} else {
				m_iteration++;
			}
			
			m_delayedCall = Starling.juggler.delayCall(spawnPieces, m_delay);
		}
		
		public function select(_x:Number):void
		{
			var touched:int = Math.floor( _x / m_size );
			if (m_selected == -1 && m_pieces[touched] != null) {
				m_selected = touched;
				m_pieces[m_selected].select();
				
			} else if (m_selected > -1) {
				m_pieces[m_selected].unselect();
				if ( m_selected != touched ) {
					swapPieces(m_selected, touched);
				}
				m_selected = -1;
			}
		}
		
		public function swap(_begin:Number, _end:Number):void
		{
			var from:int = Math.floor(_begin / m_size);
			var to:int = Math.floor(_end / m_size);
			
			if (from == to) { return; }
			swapPieces(from, to);
		}
		
		private function swapPieces(_from:int, _to:int):void
		{
			var swapped:Piece = m_pieces[_from];
			if ( swapped == null) { return; }
				
			if ( m_pieces[_to] != null ){
				m_pieces[_to].swap(_from);
			}
			m_pieces[_from] = m_pieces[_to];
			
			if (swapped != null ){
				swapped.swap(_to);
			}
			m_pieces[_to] = swapped;
		}
		
		public function get pieces():Vector.<Piece> 
		{
			return m_pieces;
		}
	}
}