package com.angrymole.mozzarella.game.time 
{
	import com.angrymole.assets.Assets;
	import com.angrymole.assets.DragonbonesAsset;
	import com.angrymole.dragonbones.StarlingArmature;
	import com.angrymole.mozzarella.events.IntroEvent;
	import com.angrymole.mozzarella.util.MathUtil;
	import dragonBones.Bone;
	import flash.geom.Matrix;
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class Timer extends Sprite implements IAnimatable
	{
		protected var m_asset:DragonbonesAsset;
		protected var m_armature:StarlingArmature;
		
		protected var m_handle:Bone;
		protected var m_text:TextField;
		
		protected var m_enabled:Boolean;
		protected var m_time:Number;
		
		protected var m_minutes:int;
		protected var m_seconds:int;
		
		public function Timer() 
		{
			m_asset = Assets.i.getAsset("layout") as DragonbonesAsset;
			m_armature = m_asset.getArmature("clock");
			addChild(m_armature.display);
			
			m_handle = m_armature.armature.getBone("clock_handle");
			
			m_text = new TextField(100, 30, "00:00");
			m_text.fontSize = 20;
			m_text.x = 10;
			m_text.y = 70;
			addChild(m_text);
			
			m_enabled = false;
			m_time = 0;
			
			Starling.juggler.add(this);
		}
		
		public function onIntroComplete(_event:IntroEvent):void
		{
			m_enabled = true;
		}
		
		public function advanceTime(_time:Number):void 
		{
			throw new Error("advanceTime must be implemented by child classes");
		}
		
		protected function update():void
		{
			m_minutes = int(m_time / 60);
			m_seconds = int(m_time % 60);
			m_text.text = formatTime(m_minutes) + ":" + formatTime(m_seconds);
			
			m_handle.origin.rotation = MathUtil.deg2rad((int(m_time) % 60) * 6);
			m_armature.advanceTime(0);
		}
		
		private function formatTime(_time:int):String
		{
			if (_time < 10) {
				return "0" + _time;
			} else { 
				return _time.toString(); 
			}
		}
	}
}