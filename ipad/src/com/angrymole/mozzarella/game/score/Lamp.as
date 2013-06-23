package com.angrymole.mozzarella.game.score 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.DragonbonesAsset;
	import com.angrymole.dragonbones.StarlingArmature;
	import dragonBones.Bone;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class Lamp extends Sprite
	{
		private var m_idx:Number;
		private var m_min:Number;
		private var m_max:Number;
		
		protected var m_asset:DragonbonesAsset;
		protected var m_armature:StarlingArmature;
		
		protected var m_off:Bone;
		protected var m_on:Bone;
		protected var m_light:Bone;
		
		public function Lamp(_idx:int, _step:int, _armature:String)
		{
			x = 40;
			y = 620 - 70 * _idx;
			
			m_idx = _idx;
			m_min = _step * _idx;
			m_max = m_min + _step;
			
			m_asset = Assets.i.getAsset("layout") as DragonbonesAsset;
			m_armature = m_asset.getArmature(_armature);
			addChild(m_armature.display);
			
			m_off = m_armature.armature.getBone("lamp_off");
			m_on = m_armature.armature.getBone("lamp_on");
			m_light = m_armature.armature.getBone("lamp_light");
		}
		
		public function update(_score:Number):void
		{
			var alpha:Number;
			
			if (_score < m_min) { alpha = 0; }
			else if (_score > m_max) { alpha = 1; }
			else { alpha = (_score - m_min) / m_max ; }
			
			m_on.display.alpha = alpha;
			m_light.display.alpha = alpha;
			m_off.display.alpha = 1 - alpha;
		}
	}

}