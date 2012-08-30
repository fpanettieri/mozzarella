using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(MozGridBehaviour))]
public class MozGridEditor : Editor
{
	public void OnEnable()
	{
		
    }
	
	override public void OnInspectorGUI()
	{
		GUILayout.Button("Add Linear");
	}
}