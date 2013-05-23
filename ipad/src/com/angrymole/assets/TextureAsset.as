package com.angrymole.assets 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class TextureAsset extends Asset
	{
		private var m_loader:Loader;
		private var m_texture:Texture;
		
		public function TextureAsset(_id:String, _path:String)
		{
			super(_id, _path);
			m_loader = new Loader();
			m_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onByteArrayLoaded );
		}
		
		override public function load(_bytes:ByteArray):void
		{
            m_loader.loadBytes( _bytes );
        }
		
		private function onByteArrayLoaded(_event:Event):void
		{
			m_texture = Texture.fromBitmap(m_loader.content as Bitmap);
			m_loader.unload();
			dispatchEvent(new AssetEvent(AssetEvent.LOADED, this));
		}
		
		override public function unload():void
		{
			m_loader.removeEventListener( Event.COMPLETE, onByteArrayLoaded );
			m_texture.dispose();
		}
		
		public function get texture():Texture 
		{
			return m_texture;
		}
	}
}