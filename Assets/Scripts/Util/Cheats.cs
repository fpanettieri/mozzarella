using UnityEngine;
using System.Collections;

public class Cheats : MonoBehaviour
{
	private Grid grid;

	public void Start()
	{
		grid = GameObject.Find( GameObjectName.GRID ).GetComponent<Grid>();
	}

	public void Update()
	{
		if(Input.GetKeyDown(KeyCode.P)) { Pause(); }
		if(Input.GetKeyDown(KeyCode.G)) { DebugGrid(); }
	}

	private void Pause()
	{
		TimeMachine.paused = !TimeMachine.paused;
	}

	public void DebugGrid()
	{
		string str = "";
		for(int i = grid.rows - 1; i >=0; i --) {
			for(int j = 0; j < grid.columns; j++) {
				str += grid.cells[j + i * grid.columns];
			}
			str += "\n";
		}
		Debug.Log(str);
	}
}
