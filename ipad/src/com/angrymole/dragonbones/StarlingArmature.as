package com.angrymole.dragonbones 
{
	import dragonBones.animation.Animation;
	import dragonBones.Armature;
	import starling.animation.IAnimatable;
	
	/**
	 * Wrapper class used to use DragonBones with the standard Starling juggler
	 * 
	 * @author Fabio Panettieri
	 */
	public class StarlingArmature implements IAnimatable 
	{
		private var m_armature:Armature;
		
		public function StarlingArmature(_armature:Armature)
		{
			m_armature = _armature;
		}
		
		public function advanceTime(_time:Number) : void
		{
			m_armature.advanceTime(_time);
		}
		
		public function dispose():void
		{
			m_armature.dispose();
		}
		
		public function get armature():Armature 
		{
			return m_armature;
		}
		
		public function get display():Object
		{
			return m_armature.display;
		}
		
		public function get animation():Animation
		{
			return m_armature.animation;
		}
	}
}