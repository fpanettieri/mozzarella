using UnityEngine;
using System.Collections;

public class FrameText : MonoBehaviour
{
	private int max = 0;
	private int current = 0;
	
	public void Update()
	{
		current = TimeMachine.frame;
		if(current > max){ max = current; }
		guiText.text = current.ToString() + " / " + max.ToString();
	}
}
