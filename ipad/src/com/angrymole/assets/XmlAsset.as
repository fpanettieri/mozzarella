package com.angrymole.assets 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class XMLAsset extends Asset
	{
		private var m_xml:XML;
		
		public function XMLAsset(_id:String, _path:String)
		{
			super(_id, _path);
		}
		
		override public function load(_bytes:ByteArray):void
		{
			m_xml = new XML(_bytes);
			dispatchEvent(new AssetEvent(AssetEvent.LOADED, this));
		}
		
		public function get xml():XML 
		{
			return m_xml;
		}
		
	}
}