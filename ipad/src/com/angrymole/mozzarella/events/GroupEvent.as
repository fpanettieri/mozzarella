package com.angrymole.mozzarella.events
{
	import com.angrymole.mozzarella.game.Group;
	
	/**
	 * Used to notify piece related events
	 * @author fpanettieri
	 */
	public class GroupEvent extends MozzarellaEvent
	{
		public static const GROUP_CREATED:String = "groupCreatedEvent";
		public static const GROUP_TOUCHED:String = "groupTouchedEvent";
		public static const GROUP_BROKEN:String = "groupBrokenEvent";
		public static const GROUP_UNGROUPED:String = "groupUngroupedEvent";
		
		private var m_group:Group;
		
		public function GroupEvent(type:String, group:Group, bubbles:Boolean = false)
		{
			super(type, bubbles);
			m_group = group;
		}
		
		public function get group():Group 
		{
			return m_group;
		}
		
	}
}
