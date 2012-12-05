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
 * Displays a user firendly level editor for mozzarella
 */ 
public class PieceMaterial
{

	public static Material getMaterial(int type)
	{
		Material material;
		switch(type) {
		case PieceType.PlainBlue:
			material = Resources.Load("Materials/Pieces/Plain/Blue") as Material;
			break;
		case PieceType.PlainGreen:
			material = Resources.Load("Materials/Pieces/Plain/Green") as Material;
			break;
		case PieceType.PlainOrange:
			material = Resources.Load("Materials/Pieces/Plain/Orange") as Material;
			break;
		case PieceType.PlainRed:
			material = Resources.Load("Materials/Pieces/Plain/Red") as Material;
			break;
		case PieceType.PlainYellow:
			material = Resources.Load("Materials/Pieces/Plain/Yellow") as Material;
			break;
		default:
			throw new System.Exception("Unsupported piece type: " + type.ToString());
		}
		return material;
	}
}
