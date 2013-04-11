package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.gestures.Tap;
	import com.angrymole.mozzarella.interfaces.IUpdatable;
	import flash.geom.Point;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Grid extends Sprite implements IUpdatable
	{
		private var m_rows:int;
		private var m_columns:int;
		
		private var m_pieces:Vector.<Piece>;
		
		private var m_placeholder:Placeholder;
		
		// TODO: create object that create groups
		// TODO: create object that break groups
		public function Grid(_cfg:Configuration) 
		{
			m_rows = _cfg.rows;
			m_columns = _cfg.columns;
			
			m_placeholder = new Placeholder(m_columns * _cfg.pieceSize, m_rows * _cfg.pieceSize, 0x9E373E);
			addChild(m_placeholder);
			
			m_pieces = new Vector.<Piece>();
		}
		
		public function push(_x:Number, _y:Number):void
		{
			trace("someone tapped me");
		}
		
		public function slash(_from:Point, _to:Point, _direciton:int, _strength:Number):void
		{
			trace("someone slashed me");
		}
		
		public function addPieces(_pieces:Vector.<Piece>):void
		{
			// TODO: append pieces to piece vector
			//-- I think there should be an int indicating where the active pieces start, ot maybe another vector with the, whatever
			// Mark them as moving, and start the animation
		}
		
		public function update(_time:Number):void
		{
			// TODO: move active pieces
		}
		
		public function onSpawn(_event:SpawnEvent):void
		{
			trace("Pieces spawned bitch!", _event.pieces);
		}
		
	}
}