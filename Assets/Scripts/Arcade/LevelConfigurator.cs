using UnityEngine;
using System.Collections.Generic;

public class LevelConfigurator : MonoBehaviour
{
	public static string selectedLevel = "arcade_w1l1";
	private static Dictionary<string, string> dict;
	
	void Awake()
	{
		TextAsset level = Resources.Load("Levels/" + selectedLevel ) as TextAsset;
		dict = new Dictionary<string, string>();
		
		string[] lines = level.text.Trim().Split('\n');
		foreach(string line in lines){
			int pos = line.IndexOf('=');
			if(pos > 1){
				string[] kv = line.Split('=');
				dict[kv[0].Trim()] = kv[1].Trim();
			} else {
				Debug.LogWarning("Malformed line: " + line);
			}
		}
		
		// Configure background
		GameObject.Find("BackgroundImage").renderer.material.mainTexture = GetTexture("background.texture");
		GameObject.Find("BackgroundImage").renderer.material.color = GetColor("background.color");
		GameObject.Find("BackgroundLayout").renderer.material.mainTexture = GetTexture("layout.texture");
		GameObject.Find("BackgroundLayout").renderer.material.color = GetColor("layout.color");
		
		GameObject.Find("Chain").GetComponent<Chain>().cooldown = GetInt("chain.cooldown");
		GameObject.Find("Chain").GetComponent<Chain>().decay = GetFloat("chain.decay");
		GameObject.Find("Countdown").GetComponent<Countdown>().time = GetInt("countdown.time");
		GameObject.Find("Countdown").GetComponent<Countdown>().fps = GetFloat("countdown.fps");
		
		GameObject.Find("Grid").GetComponent<PieceQueue>().frequency = GetString("pieces.frequency");
		GameObject.Find("Grid").GetComponent<GroupBreaker>().relativistic = GetBool("mode.relativistic");

		GameObject.Find("Time").GetComponent<TimeMachine>().relativistic = GetBool("mode.relativistic");
		GameObject.Find("Grid").GetComponent<GroupBreaker>().bonusTime = GetFloat("time.breakTimeBonus");
		GameObject.Find("Time").GetComponent<TimeJumper>().enabled = GetBool("time.jumper");
		
		GameObject.Find("IncommingPieces").GetComponent<IncommingPieces>().max = GetInt("incomming.max");
		GameObject.Find("PointsMeter").GetComponent<PointsMeter>().stars = GetIntArr("points.stars");
		
	}
	
	private string GetString(string property)
	{
		return dict[property];
	}
	
	private bool GetBool(string property)
	{
		return dict[property].ToLower().Equals("true");
	}
	
	private int GetInt(string property)
	{
		return int.Parse(dict[property]);
	}
	
	private float GetFloat(string property)
	{
		return float.Parse(dict[property]);
	}
	
	private int[] GetIntArr(string property)
	{
		string[] arr = dict[property].Split(',');
		int[] iArr = new int[arr.Length];
		for(int i = 0; i < arr.Length; i++){
			iArr[i] = int.Parse( arr[i] );
		}
		return iArr;
	}
	
	private float[] GetFloatArr(string property)
	{
		string[] arr = dict[property].Split(',');
		float[] fArr = new float[arr.Length];
		for(int i = 0; i < arr.Length; i++){
			fArr[i] = float.Parse( arr[i] );
		}
		return fArr;
	}	
	
	private Texture GetTexture(string property)
	{
		return Resources.Load(dict[property]) as Texture2D;
	}
	
	private Color GetColor(string property)
	{
		string[] rgba = dict[property].Split(',');
		return new Color(float.Parse(rgba[0]), float.Parse(rgba[1]), float.Parse(rgba[2]), float.Parse(rgba[3]));
	}
}
