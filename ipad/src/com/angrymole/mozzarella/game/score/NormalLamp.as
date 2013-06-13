package com.angrymole.mozzarella.game.score 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.DragonbonesAsset;
	import com.angrymole.dragonbones.StarlingArmature;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class NormalLamp extends Lamp
	{
		private var m_asset:DragonbonesAsset;
		private var m_armature:StarlingArmature;
		
		public function NormalLamp(_idx:int, _step:int) 
		{
			super(_idx, _step);
			x = 40;
			y = 620 - 70 * _idx;
			
			m_asset = Assets.i.getAsset("layout") as DragonbonesAsset;
			m_armature = m_asset.getArmature("lamp01");
			addChild(m_armature.display);
			
			m_off = m_armature.armature.getBone("lamp_off").display as Image;
			m_on = m_armature.armature.getBone("lamp_on").display as Image;
			m_light = m_armature.armature.getBone("lamp_light").display as Image;
		}
	}
}