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
using UnityEditor;

namespace Mozzarella {

[CustomEditor( typeof( GridBehaviour ) )]
public class GridEditor : Editor
{
	public void OnEnable()
	{
		
    }
	
	override public void OnInspectorGUI()
	{
		GUILayout.Button("Add Linear");
	}
}

} // namespace Mozzarella 
