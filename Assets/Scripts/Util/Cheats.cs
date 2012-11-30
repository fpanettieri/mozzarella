using UnityEngine;
using System.Collections;

public class Cheats : MonoBehaviour
{
	private Grid grid;
	private PiecePool pool;

	public void Start()
	{
		grid = GameObject.Find(GameObjectName.GRID).GetComponent<Grid>();
		pool = GameObject.Find(GameObjectName.GRID).GetComponent<PiecePool>();
	}

	public void Update()
	{
		if(Input.GetKeyDown(KeyCode.P)) {
			Pause();
		}
		if(Input.GetKeyDown(KeyCode.G)) {
			DebugGrid();
		}
	}

	private void Pause()
	{
		TimeMachine.paused = !TimeMachine.paused;
	}

	public void DebugGrid()
	{
		string str = "Types\n";
		for(int i = grid.rows - 1; i >=0; i --) {
			for(int j = 0; j < grid.columns; j++) {
				str += grid.pieceTypes[j + i * grid.columns];
			}
			str += "\n";
		}

		str += "\n\n\nGroups\n";
		for(int i = grid.rows - 1; i >=0; i --) {
			for(int j = 0; j < grid.columns; j++) {
				if(grid.pieceId[j + i * grid.columns] == -1){
					str += "#";
				} else {
					str += pool[grid.pieceId[j + i * grid.columns]].groups;
				}
			}
			str += "\n";
		}
		Debug.Log(str);
	}
}
