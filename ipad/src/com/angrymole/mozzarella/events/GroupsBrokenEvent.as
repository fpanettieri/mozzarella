package com.angrymole.mozzarella.events
{
	import flash.geom.Point;
	
	/**
	 * Used to notify that groups have been broken
	 * Score has to be recalculated an piecs in the gris should be repositioned
	 * 
	 * @author fpanettieri
	 */
	public class GroupsBrokenEvent extends MozzarellaEvent
	{
		public static const GROUPS_BROKEN:String = "groupsBrokenEvent";
		
		private var m_pieces:int;
		private var m_groups:int;
		private var m_centroid:Point;
		
		public function GroupsBrokenEvent(type:String, pieces:int, groups:int, centroid:Point)
		{
			super(type, bubbles);
			m_pieces = pieces;
			m_groups = groups;
			m_centroid = centroid;
		}
		
		public function get pieces():int 
		{
			return m_pieces;
		}
		
		public function get groups():int 
		{
			return m_groups;
		}
		
		public function get centroid():Point 
		{
			return m_centroid;
		}
	}
}
