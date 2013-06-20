package com.angrymole.mozzarella.util 
{
	import starling.animation.Transitions;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class CustomTransitions 
	{
		public static const SINUSOIDAL:String = "sinusoidal";
		
		public static function register():void
		{
			Transitions.register(SINUSOIDAL, sinusoidal);
		}
		
		public static function sinusoidal(_ratio:Number):Number
		{
			return Math.sin(_ratio * 6.28);
		}
	}
}