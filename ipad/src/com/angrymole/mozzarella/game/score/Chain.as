package com.angrymole.mozzarella.game.score 
{
	import com.angrymole.mozzarella.events.GroupsBrokenEvent;
	import com.angrymole.mozzarella.game.piece.PieceType;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	/**
	 * ...
	 * @author Fabio Panettieri
	 */
	public class Chain extends Sprite
	{
		private var m_score:Score;
		
		private var m_text:TextField;
		private var m_cooldown:Number;
		private var m_chain:int;
		private var m_pieceType:PieceType;
		
		private var m_delayedCall:DelayedCall;
		
		public function Chain(_score:Score) 
		{
			m_score = _score;
			m_chain = 1;
			
			m_text = new TextField(120, 120, "x1", "Verdana", 24, 0xffffff, true);
			m_text.hAlign = HAlign.RIGHT;
			addChild(m_text);
		}
		
		public function onGroupsBroken(_e:GroupsBrokenEvent):void
		{
			m_chain += m_pieceType == _e.pieceType ? 2 : 1;
			
			m_pieceType = _e.pieceType;
			m_score.multiplier = m_chain;
			m_text.text = "x" + m_chain;
			
			delayChainReset();
		}
		
		private function display():void
		{
			// TODO: animate display
		}
		
		private function hide():void
		{
			// TODO: animate hide
		}
		
		private function delayChainReset():void
		{
			if (m_delayedCall != null && !m_delayedCall.isComplete) {
				Starling.juggler.remove(m_delayedCall);
			}
			m_delayedCall = Starling.juggler.delayCall(resetChain, getResetCooldown());
		}
		
		private function resetChain():void
		{
			m_delayedCall = null;
			m_chain = 1;
			m_score.multiplier = m_chain;
			m_text.text = "x" + m_chain;
			hide();
		}
		
		private function getResetCooldown():Number
		{
			if (m_chain > 16) { return 1; }
			return (12 - m_chain) / 2;
		}
	}
}