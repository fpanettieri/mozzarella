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
	private static bool initialized = false;
	private static Material[] materials;

	public static Material getMaterial(int type)
	{
		if(!initialized){ Initialize(); }
		return materials[type];
	}

	private static void Initialize()
	{
		materials = new Material[5] {
			Resources.Load("Materials/Pieces/Plain/Empty") as Material,
			Resources.Load("Materials/Pieces/Plain/Blue") as Material,
			Resources.Load("Materials/Pieces/Plain/Green") as Material,
			Resources.Load("Materials/Pieces/Plain/Red") as Material,
			Resources.Load("Materials/Pieces/Plain/Yellow") as Material
		};
		initialized = true;
	}
}
