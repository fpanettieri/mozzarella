package com.angrymole.mozzarella.game.core 
{
	import com.angrymole.mozzarella.screens.ScreenAssets;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	/**
	 * Enqueues and load external assets.
	 * Internal asset parsing and storage is responsability of each asset
	 * 
	 * @author Fabio Panettieri
	 */
	public class Assets 
	{
		private var m_onProgress:Function;
		private var m_onComplete:Function;
		
		private var m_loader:URLLoader;
		private var m_queue:Vector.<Asset>;
		
		private var m_textures:Dictionary;
		private var m_dragonbones:Dictionary;
		
		public function Assets()
		{
			m_textures = new Dictionary();
			m_dragonbones = new Dictionary();
			
			m_loader = new URLLoader();
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
			return m_textures[_name];
		}
	}
}