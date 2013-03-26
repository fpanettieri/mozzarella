package com.angrymole.mozzarella 
{
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Game extends Sprite
	{
		public function Game()
		{
			var textField:TextField = new TextField(400, 300, "Welcome to Starling!");
			addChild(textField);
		}		
	}
}