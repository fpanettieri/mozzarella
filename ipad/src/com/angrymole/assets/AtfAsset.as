package com.angrymole.assets 
{
	import flash.utils.ByteArray;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class AtfAsset extends Asset
	{
		private var m_texture:Texture;
		
		public function AtfAsset(_id:String, _path:String)
		{
			super(_id, _path);
		}
		
		override public function load(_bytes:ByteArray):void
		{
            m_texture = Texture.fromAtfData(_bytes);
        }
		
		override public function unload():void
		{
			m_texture.dispose();
		}
		
		public function get texture():Texture 
		{
			return m_texture;
		}
	}
}