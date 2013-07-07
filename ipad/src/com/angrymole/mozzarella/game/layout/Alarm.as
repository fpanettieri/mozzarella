package com.angrymole.mozzarella.game.layout 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.AtfAsset;
	import com.angrymole.assets.SoundAsset;
	import com.angrymole.mozzarella.util.CustomTransitions;
	import flash.media.Sound;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class Alarm extends Sprite
	{
		private var m_image:Image;
		private var m_sfx:Sound;
		private var m_tween:Tween;
		
		public function Alarm() 
		{
			m_image = new Image((Assets.i.getAsset("alarmImg") as AtfAsset).texture);
			m_image.touchable = false;
			m_image.alpha = 0;
			m_image.scaleX = 4;
			m_image.scaleY = 4;
			addChild(m_image);
			
			m_sfx = (Assets.i.getAsset("alarmSfx") as SoundAsset).sound;
			m_sfx.play();
			
			m_tween = new Tween(m_image, 1, CustomTransitions.SINUSOIDAL);
			m_tween.repeatCount = 40;
			m_tween.fadeTo(0.7);
			Starling.juggler.add(m_tween);
		}	
	}
}