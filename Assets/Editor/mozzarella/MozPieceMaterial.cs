/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 @author 		Fabio R. Panettieri
 @date			2012-09-04
 @last-edit		2012-09-04
===============================================================================
*/

using UnityEditor;
using UnityEngine;

/**
 * Displays a user firendly level editor for mozzarella
 */ 
public class PieceMaterial{

	public static Material getMaterial(PieceType type){
		Material material;
		switch(type){
			case PieceType.PlainBlue:
				material = (Material)Resources.Load("Materials/Pieces/Plain/Blue");
				break;
			case PieceType.PlainGreen:
				material = (Material)Resources.Load("Materials/Pieces/Plain/Green");
				break;
			case PieceType.PlainOrange:
				material = (Material)Resources.Load("Materials/Pieces/Plain/Orange");
				break;
			case PieceType.PlainRed:
				material = (Material)Resources.Load("Materials/Pieces/Plain/Red");
				break;
			case PieceType.PlainYellow:
				material = (Material)Resources.Load("Materials/Pieces/Plain/Yellow");
				break;
			default:
				throw new System.Exception("Unsupported piece type: " + type.ToString());
			}
		return material;
	}
}
