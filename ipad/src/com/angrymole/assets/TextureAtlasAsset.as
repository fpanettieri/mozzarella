package com.angrymole.assets 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class TextureAtlasAsset extends Asset
	{
		private var m_xmlPath:String;
		private var m_loader:Loader;
		private var m_atlas:TextureAtlas;
		
		public function TextureAtlasAsset(_id:String, _path:String, _xml:String)
		{
			super(_id, _path);
			m_xmlPath = _xml;

			m_loader = new Loader();
			m_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onByteArrayLoaded );
		}
		
		override public function load(_bytes:ByteArray):void
		{
            m_loader.loadBytes( _bytes );
        }
		
		private function onByteArrayLoaded(_event:Event):void
		{
			var texture:Texture = Texture.fromBitmap(m_loader.content as Bitmap);
			var xml:XML = (Assets.i.getAsset(m_id + "Xml") as XMLAsset).xml;
			
			m_atlas = new TextureAtlas(texture, xml);
			m_loader.unload();
			dispatchEvent(new AssetEvent(AssetEvent.LOADED, this));
		}
		
		override public function unload():void
		{
			m_loader.removeEventListener( Event.COMPLETE, onByteArrayLoaded );
			m_atlas.dispose();
		}
		
		public function get atlas():TextureAtlas 
		{
			return m_atlas;
		}
		
		public function get xmlPath():String 
		{
			return m_xmlPath;
		}
	}
}