package com.angrymole.assets 
{
	import flash.utils.ByteArray;
	import starling.events.EventDispatcher;
	
	/**
	 * Used to identify an external asset that can be loaded ingame
	 * 
	 * @author Fabio Panettieri
	 */
	public class Asset extends EventDispatcher
	{
		protected var m_id:String;
		private var m_path:String;
		
		public function Asset(_id:String, _path:String)
		{
			m_id = _id;
			m_path = _path;
		}
		
		public function get id():String 
		{
			return m_id;
		}
		
		public function load(_bytes:ByteArray):void
		{
			throw new Error("Each asset type must implement custom initialization when loaded");
		}
		
		public function unload():void { }
		
		public function get path():String 
		{
			return m_path;
		}
		
		public function toString():String
		{
			return "[Asset path:" + m_path + "]";
		}
	}
}