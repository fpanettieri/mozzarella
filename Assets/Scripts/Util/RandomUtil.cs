using UnityEngine;
using System.Collections;

public class RandomUtil
{
	public static bool Bool()
	{
		 return Random.value > 0.5f;
	}
	
	public static int Sign()
	{
		 return Random.value < 0.5f ? -1 : 1;
	}
}
