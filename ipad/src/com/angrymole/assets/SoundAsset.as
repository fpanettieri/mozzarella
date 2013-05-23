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
	public class SoundAsset extends Asset
	{
		private var m_sound:Sound;
		
		public function SoundAsset(_id:String, _path:String)
		{
			super(_id, _path);
		}
		
		override public function load(_bytes:ByteArray):void
		{
			m_sound = new Sound();
			m_sound.loadCompressedDataFromByteArray(_bytes, _bytes.length);
			dispatchEvent(new AssetEvent(AssetEvent.LOADED, this));
		}
		
		override public function unload():void
		{
			
		}
		
		public function get texture():Texture 
		{
			return m_texture;
		}
	}
}