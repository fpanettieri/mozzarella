package com.angrymole.mozzarella.util 
{
	/**
	 * Contains useful math functions
	 * @author Fabio Panettieri
	 */
	public class MathUtil 
	{
		
		public static function deg2rad(_degrees:Number):Number
		{
			return _degrees * Math.PI / 180;
		}
		
		public static function rad2deg(_radians:Number):Number
		{
			return _radians * 180 / Math.PI;
		}
		
	}

}