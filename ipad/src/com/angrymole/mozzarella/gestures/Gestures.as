package com.angrymole.mozzarella.gestures 
{
	import com.angrymole.mozzarella.events.GestureEvent;
	import com.angrymole.mozzarella.game.Configuration;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * Detects simple user input and dispatch simple gestures
	 * 
	 * @author Fabio Panettieri
	 */
	public class Gestures extends Sprite
	{
		private const TAP_D_SQR:Number = 22 * 22;
		private const SWIPE_TIME:Number = 1;
		private const SAMPLING_INTERVAL:Number = 0.3;
		
		private var m_touched:Boolean;
		private var m_begin:Point;
		private var m_end:Point;
		private var m_beginTime:Number;
		private var m_endTime:Number;
		
		private var m_elapsed:Number;
		private var m_nodes:Vector.<Point>;
		
		public function Gestures() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(_e:Event = null):void
		{
			m_touched = false;
			m_nodes = new Vector.<Point>();
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(_e:TouchEvent):void
		{
			var touch:Touch = _e.getTouch(stage);
			if ( touch == null ) { return; }
			
			if (m_touched && touch.phase == TouchPhase.MOVED) {
				
				// FIXME: GET ELAPSED TIME!!
				m_elapsed += 0;//Starling.juggler.;
				trace(m_elapsed);
				
				if ( m_elapsed > SAMPLING_INTERVAL ) {
					m_elapsed = 0;
					m_nodes.push( new Point(touch.globalX, touch.globalY) );
				}
				
			} else if (touch.phase == TouchPhase.BEGAN) {
				m_elapsed = 0;
				m_touched = true;
				m_begin = new Point(touch.globalX, touch.globalY);
				m_beginTime = touch.timestamp;
				m_nodes.length = 0;
			
			} else if (touch.phase == TouchPhase.ENDED) {
				m_end = new Point(touch.globalX, touch.globalY);
				m_endTime = touch.timestamp;
				processGesture();
				m_touched = false;
			}
		}
		
		private function processGesture():void
		{
			var dx:Number = m_end.x - m_begin.x;
			var dy:Number = m_end.y - m_begin.y;
			var dSrq:Number = dx * dx + dy * dy;
			var duration:Number = m_endTime - m_beginTime;
			
			var type:String;
			var gesture:Gesture;
			
			if ( dSrq < TAP_D_SQR ) {
				type = GestureEvent.TAP_GESTURE;
				gesture = new Tap(m_begin, m_end, duration);
				
			} else if ( duration < SWIPE_TIME ) {
				type = GestureEvent.SWIPE_GESTURE;
				gesture = new Swipe(m_begin, m_end, duration);
				
			} else if ( m_nodes.length > 1) {
				type = GestureEvent.PATH_GESTURE;
				gesture = new Path(m_begin, m_end, duration, m_nodes);
				
			} else {
				// TODO: debug useful variables to detect why it failed
				throw new Error("Unidentified gesture");
			}
			
			dispatchEvent(new GestureEvent(type, gesture));
		}
	}
}