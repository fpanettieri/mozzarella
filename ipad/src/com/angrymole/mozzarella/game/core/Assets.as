package com.angrymole.mozzarella.game.core 
{
	import flash.filesystem.File;
	import starling.utils.AssetManager;
	
	/**
	 * Used to handle external assets loading
	 * @author Fabio Panettieri
	 */
	public class Assets 
	{
		private var m_appDir:File;
		private var m_manager:AssetManager;
		
		private var m_onProgress:Function;
		private var m_onComplete:Function;
		
		public function Assets() 
		{
			m_appDir = File.applicationDirectory;
			
			m_manager = new AssetManager();
			m_manager.verbose = true;
		}
		
		public function load(_onProgress:Function, _onComplete:Function):void
		{
			m_onProgress = _onProgress;
			m_onComplete = _onComplete;
			
			m_manager.enqueue(m_appDir.resolvePath("assets"));
			m_manager.loadQueue(onProgress);
		}
		
		public function get manager():AssetManager 
		{
			return m_manager;
		}
		
		private function onProgress(_progress:Number):void
		{
			trace("Loading assets, progress:", _progress);
			m_onProgress(_progress);
			
			if (_progress < 1) { return; }
			m_onComplete();
		}
	}
}