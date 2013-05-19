package com.angrymole.mozzarella.game.piece 
{
	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;
	import starling.events.Event;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class AnimatedAsset
	{
		private var m_factory:StarlingFactory;
		private var m_armature:Armature;
		private var m_loaded:Boolean;
		
		public function AnimatedAsset(_resource:Class) extends PieceAsset
		{
			m_loaded = false;
			m_factory = new StarlingFactory();
			m_factory.addEventListener(Event.COMPLETE, onAssetParsed);
			m_factory.parseData( new _resource());
		}
		
		private function onAssetParsed(_event:Event):void
		{
			m_armature = m_factory.buildArmature("WigTest");
			m_loaded = true;
		}
		
		public function get asset():Sprite
		{
			return m_armature.display;
		}
		
		public function get loaded():Boolean 
		{
			return m_loaded;
		}
	}
}