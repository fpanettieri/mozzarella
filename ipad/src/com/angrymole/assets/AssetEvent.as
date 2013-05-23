package com.angrymole.assets 
{
	import starling.events.Event;
	
	/**
	 * Used to notify asset loading evetns
	 * @author Fabio Panettieri
	 */
	public class AssetEvent extends Event
	{
		public static const ERROR:String = "assetErrorEvent";
		public static const LOADED:String = "assetLoadedEvent";
		public static const UNLOADED:String = "assetUnloadedEvent";
		
		private var m_asset:Asset;
		
		public function AssetEvent(_type:String, _asset:Asset, _bubbles:Boolean =false) 
		{
			super(_type, _bubbles);
			m_asset = _asset;
		}
		
		public function get asset():Asset 
		{
			return m_asset;
		}
	}
}