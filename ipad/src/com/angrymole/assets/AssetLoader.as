package com.angrymole.assets 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * Used to queue and load external assets that have not been loaded or initialized yet
	 * 
	 * @author Fabio Panettieri
	 */
	public class AssetLoader extends EventDispatcher
	{
		private var m_onProgress:Function;
		private var m_onComplete:Function;
		
		private var m_loader:URLLoader;
		private var m_queue:Vector.<Asset>;
		
		private var m_index:int;
		private var m_progress:Number;
		private var m_loading:Boolean;
		
		public function AssetLoader() 
		{
			m_loader = new URLLoader();
			m_loader.dataFormat = URLLoaderDataFormat.BINARY;
			m_loader.addEventListener(Event.COMPLETE, onLoadComplete);
			m_loader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			m_loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			m_loading = false;
		}
		
		public function load(_assets:Vector.<Asset>, _onProgress:Function, _onComplete:Function):void
		{
			if (m_loading) { throw new Error("The AssetLoader is already working, something went wrong.");	}
			m_loading = true;
			
			m_onProgress = _onProgress;
			m_onComplete = _onComplete;
			
			m_queue = _assets;
			m_index = 0;
			m_progress = 0;
			
			m_loader.load( new URLRequest(m_queue[m_index].path) );
		}
		
		private function onLoadComplete(_event:Event):void
		{
			m_queue[m_index].addEventListener(AssetEvent.LOADED, onAssetInitialized)
			m_queue[m_index].load(m_loader.data as ByteArray);
		}
		
		private function onAssetInitialized(_event:AssetEvent):void
		{
			m_queue[m_index].removeEventListener(AssetEvent.LOADED, onAssetInitialized);
			
			if ( ++m_index < m_queue.length) {
				m_loader.load( new URLRequest(m_queue[m_index].path) );
				return;
			}
			
			m_onComplete();
			m_loading = false;
			
		}
		
		private function onLoadProgress(_event:ProgressEvent):void
		{
			m_progress = (m_index + m_loader.bytesLoaded / m_loader.bytesTotal) / m_queue.length;
			trace("progress:", m_progress);
			m_onProgress(m_progress);
		}
		
		private function onLoadError(_event:IOErrorEvent):void
		{
			throw new Error("Error loading asset:", m_queue[m_index]);
		}
		
		public function get progress():Number 
		{
			return m_progress;
		}
	}
}