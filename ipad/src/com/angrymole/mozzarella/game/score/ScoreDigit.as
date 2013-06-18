package com.angrymole.mozzarella.game.score 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.DragonbonesAsset;
	import com.angrymole.dragonbones.StarlingArmature;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class ScoreDigit extends Sprite
	{
		private var m_idx:int;
		
		private var m_asset:DragonbonesAsset;
		private var m_armature:StarlingArmature;
		private var m_text:TextField;
		
		public function ScoreDigit(_idx:int) 
		{
			m_idx = _idx;
			x = _idx * 40;
			
			m_asset = Assets.i.getAsset("layout") as DragonbonesAsset;
			m_armature = m_asset.getArmature("score");
			m_armature.display.x = 10;
			m_armature.display.y = 15;
			m_armature.display.scaleX = 0.7;
			m_armature.display.scaleY = 0.7;
			addChild(m_armature.display);
			
			m_text = new TextField(20, 30, "0");
			m_text.color = 0xFFFFFF;
			m_text.fontSize = 24;
			m_text.hAlign = HAlign.CENTER;
			m_text.vAlign = VAlign.CENTER;
			addChild(m_text);
		}
		
		public function update(_score:String):void
		{
			m_text.text = _score.substr(m_idx, 1);
		}
		
	}

}