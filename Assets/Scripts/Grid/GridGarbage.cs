using UnityEngine;
using System.Collections;

public class GridGarbage : MonoBehaviour
{
	// Inspector properties
	public int height = 3;
	public float dirtyness = 0.5f;
	public static int colors;

	// Injected dependency
	private Grid grid;

	public void Awake()
	{
		colors = Random.value > 0.5f ? 3 : 4;

		grid = GetComponent<Grid>();
		int garbage;
		for(int row = 0; row < height; row++){
			for(int column = 0; column < grid.columns; column++){
				if(Random.value > dirtyness){ continue; }

				garbage = Mathf.CeilToInt( Random.value * (colors - 1) ) + 1;
				if(row == 0){
					grid.pieceTypes[column + row * grid.columns] = garbage;

				} else if(grid.pieceTypes[column + (row - 1) * grid.columns] > 0){
					while(grid.pieceTypes[column + (row - 1) * grid.columns] == garbage){
						garbage = ++garbage % colors;
					}
					grid.pieceTypes[column + row * grid.columns] = garbage;
				}

			}
		}

	}

}
