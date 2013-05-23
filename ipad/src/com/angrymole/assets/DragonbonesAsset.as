package com.angrymole.assets 
{
	import com.angrymole.dragonbones.StarlingArmature;
	import dragonBones.factorys.StarlingFactory;
	import flash.events.Event;

	import flash.utils.ByteArray;
	
	/**
	 * Contains an decoded dargonbones png taht can be used to create armatures
	 * 
	 * @author Fabio Panettieri
	 */
	public class DragonbonesAsset extends Asset
	{
		private var m_factory:StarlingFactory;
		
		public function DragonbonesAsset(_id:String, _path:String)
		{
			super(_id, _path);
			m_factory = new StarlingFactory();
			m_factory.addEventListener(Event.COMPLETE, onDataParsed);
		}
		
		override public function load(_bytes:ByteArray):void
		{
			m_factory.parseData(_bytes);
		}
		
		private function onDataParsed(_event:Event):void
		{
			dispatchEvent(new AssetEvent(AssetEvent.LOADED, this));
		}
		
		override public function unload():void
		{
			m_factory.dispose();
		}
		
		public function getArmature(_name:String):StarlingArmature 
		{
			return new StarlingArmature(m_factory.buildArmature(_name));
		}
	}
}