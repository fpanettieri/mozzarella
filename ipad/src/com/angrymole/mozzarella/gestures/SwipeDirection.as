package com.angrymole.mozzarella.gestures 
{
	import flash.geom.Point;
	/**
	 * Identifies 8 possible swipe direction
	 * They are enumerated clockwise, starting from 1 at the top
	 * 
	 * @author Fabio Panettieri
	 */
	public class SwipeDirection
	{
		public static const NONE:int = 0;
		public static const LEFT:int = 1;
		public static const UP_LEFT:int = 2;
		public static const UP:int = 3;
		public static const UP_RIGHT:int = 4;
		public static const RIGHT:int = 5;
		public static const DOWN_RIGHT:int = 6;
		public static const DOWN:int = 7;
		public static const DOWN_LEFT:int = 8;
		
		public static function getDirection(_begin:Point, _end:Point):int
		{
			var rad:Number = Math.atan2(_begin.y - _end.y, _begin.x - _end.x);
			
			if (rad >= -0.39269908125 && rad <= 0.39269908125) {
				return LEFT;
			
			} else if (rad >= 0.39269908124 && rad <= 1.17809724375) {
				return UP_LEFT;
			
			} else if (rad >= 1.17809724375 && rad <= 1.96349540625) {
				return UP;
				
			} else if (rad >= 1.96349540625 && rad <= 2.74889356875) {
				return UP_RIGHT;
			
			} else if ((rad >= 2.74889356875 && rad <= 3.5) || (rad >= -3.5 && rad <= -2.74889356875)) {
				return RIGHT;
			
			} else if (rad >= -2.74889356875 && rad <= -1.96349540625) {
				return DOWN_RIGHT;
			
			} else if (rad >= -1.96349540625 && rad <= -1.17809724375) {
				return DOWN;
			
			} else if (rad >= -1.17809724375 && rad <= -0.39269908125) {
				return DOWN_LEFT;
			}
			
			throw new Error("Swipe direction couldn't be detected");
		}
	}

}