package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.PieceEvent;
	import com.angrymole.mozzarella.events.SpawnEvent;
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
		private var m_row:int;
		private var m_column:int;
		private var m_type:PieceType;
		private var m_size:int;
		private var m_selected:Boolean;
		private var m_swappable:Boolean;
		private var m_groups:Vector.<Group>;
		private var m_iteration:int;
		private var m_tween:Tween;
		
		private var m_placeholder:Placeholder;
		
		public function Piece(_row:int, _column:int, _type:PieceType, _size:int, _iteration:int) 
		{
			m_row = _row;
			m_column = _column;
			m_type = _type;
			m_size = _size;
			m_selected = false;
			m_swappable = true;
			m_groups = new Vector.<Group>();
			m_iteration = _iteration;
			
			m_placeholder = new Placeholder(_size, _size, m_type.color);
			addChild(m_placeholder);
		}
		
		public function intro():void
		{
			m_tween = new Tween(this, 0.3, Transitions.EASE_OUT_BACK);
			m_tween.moveTo(x, 0);
			m_tween.delay = Math.random() * 0.2;
			m_tween.onComplete = onIntroComplete;
			Starling.juggler.add(m_tween);
		}
		
		private function onIntroComplete():void
		{
			dispatchEvent(new SpawnEvent(SpawnEvent.SPAWN_PIECE));
		}
		
		public function select():void
		{
			x = m_column * m_size;
			y = 0;
			
			var tween:Tween = new Tween(this, 0.1, Transitions.LINEAR);
			tween.scaleTo(1.2);
			tween.moveTo(x - 6, -6);
			Starling.juggler.add(tween);
			
			parent.setChildIndex(this, parent.numChildren - 1);
			m_selected = true;
		}
		
		public function unselect():void
		{
			var tween:Tween = new Tween(this, 0.1, Transitions.LINEAR);
			tween.scaleTo(1);
			tween.moveTo(m_column * m_size, 0);
			m_tween.onComplete = onSelectComplete;
			Starling.juggler.add(tween);
		}
		
		public function swap(_column:int, _time:Number):void
		{
			m_column = _column;
			m_swappable = false;
			
			m_tween = new Tween(this, _time, Transitions.EASE_IN_OUT);
			m_tween.scaleTo(1);
			m_tween.moveTo(m_column * m_size, 0);
			m_tween.onComplete = onSwapComplete;
			Starling.juggler.add(m_tween);
		}
		
		private function onSelectComplete():void
		{
			m_selected = false;
		}
		
		private function onSwapComplete():void
		{
			m_swappable = true;
		}
		
		public function drop(_from:int, _to:int):void
		{
			m_row = _to;
			x = m_column * m_size;
			
			var duration:Number = (_from - _to) * 0.1;
			var tween:Tween = new Tween(this, duration, Transitions.EASE_OUT_BOUNCE);
			tween.moveTo(x, _to * m_size);
			tween.onComplete = onDropComplete;
			Starling.juggler.add(tween);
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
		
		private function onDropComplete():void
		{
			dispatchEvent(new PieceEvent(PieceEvent.PIECE_DROPPED, this));
		}
		
		public function get row():int 
		{
			return m_row;
		}
		
		public function set row(value:int):void 
		{
			m_row = value;
		}
		
		public function get column():int 
		{
			return m_column;
		}
		
		public function set column(value:int):void 
		{
			m_column = value;
		}
		
		public function get type():PieceType 
		{
			return m_type;
		}
		
		public function get size():int 
		{
			return m_size;
		}
		
		public function get iteration():int 
		{
			return m_iteration;
		}
		
		public function get selected():Boolean 
		{
			return m_selected;
		}
		
		public function get swappable():Boolean 
		{
			return m_swappable;
		}
		
		public function set swappable(value:Boolean):void 
		{
			m_swappable = value;
		}
		
		public function get groups():Vector.<Group> 
		{
			return m_groups;
		}
		
		public function get grouped():Boolean 
		{
			return m_groups.length > 0;
		}
		
		public function toString():String
		{
			return "[Piece r: " + m_row + " c: " + m_column + " t: " + m_type + " ]";
		}
	}
}