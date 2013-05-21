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
			
			m_text = new TextField(400, 400, ". . .", "Verdana", 64, 0xffD0D0D0);
			m_text.x = (1024 - 400) / 2;
			m_text.y = (768 - 400) / 2;
			m_text.hAlign = HAlign.CENTER;
			m_text.vAlign = VAlign.CENTER;
			addChild(m_text);

			Starling.juggler.delayCall(setText, 1, "o . .");
			Starling.juggler.delayCall(setText, 2, "o o .");
			Starling.juggler.delayCall(setText, 3, "o o o");
			Starling.juggler.delayCall(dispatchEvent, 4, new IntroEvent(IntroEvent.INTRO_COMPLETE));
			Starling.juggler.delayCall(removeChild, 4, m_text);
		}
		
		private function setText(_text:String):void
		{
			m_text.text = _text;
		}
	}
}