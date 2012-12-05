/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;

/**
 * Color factory method
 */ 
public class PieceColor
{

	public static Color getColor(int type)
	{
		Color color;
		switch(type) {
		case PieceType.Empty:
			color = new Color(0.0f, 0.0f, 0.0f, 0.0f);
			break;
		case PieceType.PlainBlue:
			color = new Color(0.47f, 0.7f, 0.85f, 1.0f);
			break;
		case PieceType.PlainGreen:
			color = new Color(0.52f, 0.65f, 0.38f, 1.0f);
			break;
		case PieceType.PlainOrange:
			color = new Color(0.96f, 0.56f, 0.38f, 1.0f);
			break;
		case PieceType.PlainRed:
			color = new Color(0.8f, 0.36f, 0.33f, 1.0f);
			break;
		case PieceType.PlainYellow:
			color = new Color(1.0f, 1.0f, 0.80f, 1.0f);
			break;
		default:
			color = Color.magenta;
			break;
		}
		return color;
	}
}
