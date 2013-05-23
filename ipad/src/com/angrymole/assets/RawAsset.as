package com.angrymole.assets 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class RawAsset extends Asset
	{
		private var m_bytes:ByteArray;
		
		public function RawAsset(_id:String, _path:String)
		{
			super(_id, _path);
		}
		
		override public function load(_bytes:ByteArray):void
		{
			m_bytes = _bytes
			dispatchEvent(new AssetEvent(AssetEvent.LOADED, this));
		}
		
		public function get bytes():ByteArray 
		{
			return m_bytes;
		}
	}
}