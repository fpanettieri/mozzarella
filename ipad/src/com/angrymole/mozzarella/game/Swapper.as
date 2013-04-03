package com.angrymole.mozzarella.game 
{
	import com.angrymole.mozzarella.events.SpawnEvent;
	import starling.display.Sprite;
	/**
	 * Handles piece swapping input and swap newly created pieces
	 * 
	 * @author Fabio Panettieri
	 */
	public class Swapper extends Sprite 
	{
		public function Swapper(_cfg:Configuration)
		{
		
		}
		
		public function onSpawnComplete(_event:SpawnEvent):void
		{
			// TODO: add touch listener to pieces
			
			trace(_event.pieces);
		}
	}
}