package com.angrymole.mozzarella.game 
{
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
		private var m_swappable:Boolean;
		private var m_selected:Boolean;
		
		private var m_placeholder:Placeholder;
		
		public function Piece(_row:int, _column:int, _type:PieceType, _size:int, _swappable:Boolean) 
		{
			m_row = _row;
			m_column = _column;
			m_type = _type;
			m_size = _size;
			m_swappable = _swappable;
			m_selected = false;
			
			m_placeholder = new Placeholder(_size, _size, m_type.color);
			addChild(m_placeholder);
		}
		
		public function intro():void
		{
			var tween:Tween = new Tween(this, 0.3, Transitions.EASE_OUT_BACK);
			tween.moveTo(x, 0);
			tween.delay = Math.random() * 0.2;
			tween.onComplete = onIntroComplete;
			Starling.juggler.add(tween);
		}
		
		private function onIntroComplete():void
		{
			dispatchEvent(new SpawnEvent(SpawnEvent.SPAWN_PIECE));
		}
		
		public function select():void
		{
			var tweenIn:Tween = new Tween(this, 0.2, Transitions.EASE_IN_OUT_BACK);
			tweenIn.scaleTo(1.2);
			Starling.juggler.add(tweenIn);
			
			var tweenOut:Tween = new Tween(this, 0.1, Transitions.LINEAR);
			tweenOut.delay = 0.2;
			tweenOut.scaleTo(1);
			Starling.juggler.add(tweenOut);
		}
		
		public function unselect():void
		{
			// TODO: stop select animation
		}
		
		public function swap(_column:int, _time:Number):void
		{
			m_column = _column;
			m_swappable = false;
			
			var tween:Tween = new Tween(this, _time, Transitions.EASE_IN_OUT);
			tween.moveTo(m_column * m_size, y);
			tween.onComplete = onSwapComplete;
			Starling.juggler.add(tween);
		}
		
		private function onSwapComplete():void
		{
			m_swappable = true;
		}
		
		public function get row():int 
		{
			return m_row;
		}
		
		public function get column():int 
		{
			return m_column;
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
		
		public function toString():String
		{
			return "[Piece r: " + m_row + " c: " + m_column + " t: " + m_type + " ]";
		}
	}
}