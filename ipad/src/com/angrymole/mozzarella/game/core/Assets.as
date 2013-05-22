package com.angrymole.mozzarella.game.core 
{
	import com.angrymole.mozzarella.screens.ScreenAssets;
	import flash.filesystem.File;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	/**
	 * Used to handle external assets loading
	 * @author Fabio Panettieri
	 */
	public class Assets 
	{
		private var m_onProgress:Function;
		private var m_onComplete:Function;
		
		public function Assets() 
		{
		}
		
		public function load(_assets:ScreenAssets, _onProgress:Function, _onComplete:Function):void
		{
			// load missing assets
			
		}
		
		public function dispose(_assets:ScreenAssets):void
		{
			// remove unused assets
			// load missing assets
			
		}
		
		public function getTexture(_name:String):Texture
		{
			return null;
		}
	}
}