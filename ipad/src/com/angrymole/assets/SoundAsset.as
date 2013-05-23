package com.angrymole.assets 
{
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
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
		
		public function get sound():Sound 
		{
			return m_sound;
		}
	}
}