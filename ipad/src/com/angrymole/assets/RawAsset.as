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
		
		override public function unload():void
		{
			
		}
		
		public function get bytes():ByteArray 
		{
			return m_bytes;
		}
	}
}