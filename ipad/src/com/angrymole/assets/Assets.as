package com.angrymole.assets 
{
	import com.angrymole.mozzarella.Game;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.utils.Dictionary;
	
	/**
	 * Ensures only one copy of the resource exists in memory at the given time.
	 * Manage lifetime of resources loading and unloading them as needed.
	 * 
	 * @author Fabio Panettieri
	 */
	public class Assets 
	{
		private var m_assets:Dictionary;
		private var m_loader:AssetLoader;
		
		public static function get i():Assets
		{
			return Game.current.assets;
		}
		
		public function Assets()
		{
			m_assets = new Dictionary();
			m_loader = new AssetLoader();
			m_loader.addEventListener(AssetEvent.LOADED, onAssetLoaded);
		}
		
		public function load(_assets:Vector.<Asset>, _onProgress:Function, _onComplete:Function):void
		{
			m_loader.load(_assets, _onProgress, _onComplete);
		}
		
		public function unload(_assets:Vector.<Asset>):void
		{
			for ( var i:int = _assets.length - 1; i > -1;  i-- ) {
				_assets[i].unload();
				delete m_assets[_assets[i].id];
			}
		}
		
		public function getAsset(_name:String):Asset
		{
			return m_assets[_name];
		}
		
		public function contains(_name:String):Boolean
		{
			return _name in m_assets;
		}
		
		private function onAssetLoaded(_event:AssetEvent):void
		{
			m_assets[_event.asset.id] = _event.asset;
		}
	}
}