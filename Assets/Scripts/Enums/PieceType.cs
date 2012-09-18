/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-08-30
 @last-edit		2012-08-30
===============================================================================
*/

using UnityEngine;

/**
 * All the available piece types
 */ 
public class PieceType
{
	public const int Empty 				= 0;
	public const int PlainBlue 			= 1;
	public const int PlainGreen 		= 2;
	public const int PlainOrange		= 3;
    public const int PlainRed			= 4;
	public const int PlainYellow		= 5;
	
	public static string[] Names		= {
		"Empty", "PlainBlue", "PlainGreen", "PlainOrange", "PlainRed", "PlainYellow"
	};
}
