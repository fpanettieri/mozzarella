package com.angrymole.assets 
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class XmlAsset extends Asset
	{
		private var m_xml:XML;
		
		public function XmlAsset(_id:String, _path:String)
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