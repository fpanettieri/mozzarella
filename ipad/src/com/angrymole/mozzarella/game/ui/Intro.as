package com.angrymole.mozzarella.game.ui 
{
	import com.angrymole.mozzarella.events.IntroEvent;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * Dispatch the IntroStarted event
	 * Displays the 3,2,1 go animation
	 * Make the pieces appear in order
	 * Dispatch the IntroComplete event
	 * 
	 * @author Fabio Panettieri
	 */
	public class Intro extends Sprite 
	{
		private var m_text:TextField;
		
		public function Intro() 
		{
			dispatchEvent(new IntroEvent(IntroEvent.INTRO_STARTED));
			
			m_text = new TextField(400, 400, "3", "Verdana", 80);
			m_text.x = (1024 - 400) / 2;
			m_text.y = (768 - 400) / 2;
			m_text.hAlign = HAlign.CENTER;
			m_text.vAlign = VAlign.CENTER;
			m_text.scaleX = 0
			m_text.scaleX = 0;
			addChild(m_text);
			
			Starling.juggler.tween(m_text, 0.5, {
				delay: 0,
				scaleX: 1,
				scaleY: 1
			});
			
			Starling.juggler.tween(m_text, 0.5, {
				delay: 0.5,
				scaleX: 0.2,
				scaleY: 0.2,
				onComplete: setText,
				onCompleteArgs: ["2"]
			});
			
			Starling.juggler.tween(m_text, 0.5, {
				delay: 1,
				scaleX: 1,
				scaleY: 1
			});
			
			Starling.juggler.tween(m_text, 0.5, {
				delay: 1.5,
				scaleX: 0.2,
				scaleY: 0.2,
				onComplete: setText,
				onCompleteArgs: ["1"]
			});
			
			Starling.juggler.tween(m_text, 0.5, {
				delay: 2,
				scaleX: 1,
				scaleY: 1
			});
			
			Starling.juggler.tween(m_text, 0.5, {
				delay: 2.5,
				scaleX: 0.2,
				scaleY: 0.2,
				onComplete: setText,
				onCompleteArgs: ["GO!"]
			});
			
			Starling.juggler.tween(m_text, 0.5, {
				delay: 3,
				scaleX: 1,
				scaleY: 1
			});
			
			Starling.juggler.tween(m_text, 0.5, {
				delay: 3.5,
				scaleX: 0,
				scaleY: 0,
				onComplete: dispatchEvent,
				onCompleteArgs: [new IntroEvent(IntroEvent.INTRO_COMPLETE)]
			});
		}
		
		private function setText(_text:String):void
		{
			m_text.text = _text;
		}
	}
}