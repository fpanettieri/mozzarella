package com.angrymole.mozzarella.game.piece 
{
	import com.angrymole.mozzarella.constants.Constants;
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
	import com.angrymole.mozzarella.util.CustomTransitions;
	import com.angrymole.mozzarella.util.Placeholder;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Piece extends Sprite 
	{
		private var m_asset:PieceAsset;
		private var m_row:int;
		private var m_column:int;
		private var m_prevRow:int;
		private var m_prevColumn:int;
		private var m_type:PieceType;
		private var m_size:int;
		private var m_swappable:Boolean;
		private var m_groups:Vector.<Group>;
		private var m_tween:Tween;
		
		public function Piece(_row:int, _column:int, _type:PieceType, _size:int) 
		{
			m_prevRow = _row;
			m_prevColumn = _column;
			m_row = _row;
			m_column = _column;
			m_type = _type;
			m_size = _size;
			m_swappable = true;
			m_groups = new Vector.<Group>();
			
			m_asset = PieceAssetFactory.getAsset(_type);
			addChild(m_asset.asset);
		}
		
		public function intro():void
		{
			m_tween = new Tween(this, 0.3, Transitions.EASE_OUT_BACK);
			m_tween.moveTo(x, 0);
			m_tween.delay = Math.random() * 0.2;
			m_tween.onComplete = dispatchEvent;
			m_tween.onCompleteArgs = [new SpawnEvent(SpawnEvent.SPAWN_PIECE)];
			Starling.juggler.add(m_tween);
		}
		
		public function shake():void
		{
			var tween:Tween = new Tween(this, 0.25, CustomTransitions.SINUSOIDAL);
			tween.repeatCount = 15;
			tween.moveTo(x, y + 5);
			Starling.juggler.add(tween);
		}

		public function grab():void
		{
			x = m_column * m_size - Constants.GRABBED_MARGIN;
			y = -Constants.GRABBED_MARGIN;
			scaleX = 1.3;
			scaleY = 1.3;
			
			parent.setChildIndex(this, parent.numChildren - 1);
			
			// TODO: play grab sound
		}
		
		public function swap(_column:int, _duration:Number):void
		{
			var duration:Number = Math.abs(m_column - _column) * _duration;
			m_prevColumn = m_column;
			m_column = _column;
			m_swappable = false;
			
			m_tween = new Tween(this, duration, Transitions.EASE_IN_OUT);
			m_tween.moveTo(m_column * m_size, 0);
			m_tween.scaleTo(1);
			m_tween.onComplete = onSwapComplete;
			Starling.juggler.add(m_tween);
			
			// TODO: play swap sound
		}
		
		private function onSwapComplete():void
		{
			m_swappable = true;
			dispatchEvent(new PieceEvent(PieceEvent.PIECE_UPDATED, this, true));
		}
		
		public function drop(_from:int, _to:int):void
		{
			m_prevRow = _from;
			m_row = _to;
			x = m_column * m_size;
			
			var duration:Number = Math.abs(_from - _to) * 0.1;
			var tween:Tween = new Tween(this, duration, Transitions.EASE_OUT_BOUNCE);
			tween.moveTo(x, _to * m_size);
			tween.scaleTo(1);
			tween.onComplete = dispatchEvent
			tween.onCompleteArgs = [new PieceEvent(PieceEvent.PIECE_UPDATED, this)];
			queueTween(tween);
			
			// TODO: play drop sound
		}
		
		public function push():void
		{
			m_prevRow = m_row++;
			
			var duration:Number = 0.1;
			var tween:Tween = new Tween(this, duration, Transitions.EASE_OUT_BOUNCE);
			tween.moveTo(x, y + m_size);
			tween.onComplete = dispatchEvent
			tween.onCompleteArgs = [new PieceEvent(PieceEvent.PIECE_UPDATED, this)];
			queueTween(tween);
		}
		
		public function lock():void
		{
			m_swappable = false;
		}
		
		public function addGroup(_group:Group):void
		{
			m_groups.push(_group);
		}
		
		public function removeGroup(_group:Group):void
		{
			var idx:int = m_groups.indexOf(_group);
			if (idx < 0) { return; }
			m_groups.splice(idx, 1);
			
			// TODO: pop animation?
			visible = m_groups.length == 0;
		}
		
		public function clearGroups():void
		{
			m_groups.length = 0;
		}
		
		public function ungroup():void
		{
			for ( var i:int = 0; i < m_groups.length; i++) {
				m_groups[i].ungroup();
			}
		}
		
		private function queueTween(_tween:Tween):void
		{
			if (m_tween == null || m_tween.isComplete) {
				m_tween = _tween;
				Starling.juggler.add(m_tween);
			} else {
				m_tween.nextTween = _tween;
				m_tween = _tween;
			}
		}

		public function get row():int 
		{
			return m_row;
		}
		
		public function get column():int 
		{
			return m_column;
		}
		
		public function get prevRow():int 
		{
			return m_prevRow;
		}
		
		public function get prevColumn():int 
		{
			return m_prevColumn;
		}
		
		public function get type():PieceType 
		{
			return m_type;
		}
		
		public function get size():int 
		{
			return m_size;
		}
		
		public function get swappable():Boolean 
		{
			return m_swappable;
		}
		
		public function get groups():Vector.<Group> 
		{
			return m_groups;
		}
		
		public function get grouped():Boolean 
		{
			return m_groups.length > 0;
		}
		
		public function get asset():PieceAsset 
		{
			return m_asset;
		}
		
		public function toString():String
		{
			return "[Piece r: " + m_row + " c: " + m_column + " t: " + m_type + " ]";
		}
	}
}