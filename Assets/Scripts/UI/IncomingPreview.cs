/*
===============================================================================
 Copyright (C) 2012-2014 Angry Mole
 This file is part of Mozzarella source code
 
 Author
 	Fabio R. Panettieri [ fpanettieri{at}gmail{dot}com ]
===============================================================================
*/
using UnityEngine;
using System.Collections;

public class IncomingPreview: MonoBehaviour
{
	// inspector propertiesx
	public int columns;
	public int rows;
	public int width;
	public int height;

	// internal state
	private Material[] materials;

	// aux variables
	private IntVector2 size;
	private int idx;
	private Mesh mesh;
	private MeshFilter filter;

	public void Start()
	{
		filter = GetComponent<MeshFilter>();
		size = new IntVector2(Mathf.FloorToInt(width / columns), Mathf.FloorToInt(height / rows));

		mesh = new Mesh();
		mesh.name = "IncomingPreview";
		mesh.subMeshCount = columns * rows;

		mesh.vertices = new Vector3[mesh.subMeshCount * 4];
		mesh.uv = new Vector2[mesh.subMeshCount * 4];

		for(int row = 0; row < rows; row++){
			for(int column = 0; column < columns; column++){
				idx = column + row * columns;

				// vertices
				mesh.vertices[idx * 4    ] = new Vector3(size.x * column, size.y * (row + 1));
				mesh.vertices[idx * 4 + 1] = new Vector3(size.x * (column + 1), size.y * (row + 1));
				mesh.vertices[idx * 4 + 2] = new Vector3(size.x * (column + 1), size.y * row);
				mesh.vertices[idx * 4 + 3] = new Vector3(size.x * column, size.y * row);

				// uv
				mesh.uv[idx * 4    ] = new Vector2(0, 1);
				mesh.uv[idx * 4 + 1] = new Vector2(1, 1);
				mesh.uv[idx * 4 + 2] = new Vector2(1, 0);
				mesh.uv[idx * 4 + 3] = new Vector2(0, 0);

				// triangles
				mesh.SetTriangles(new int[6]{idx, idx + 1, idx + 2, idx + 2, idx + 3, idx}, idx);
			}
		}

		mesh.RecalculateBounds();
		mesh.RecalculateNormals();

		filter.mesh = mesh;

		materials = new Material[mesh.subMeshCount];
		for(int row = 0; row < rows; row++){
			for(int column = 0; column < columns; column++){
				idx = column + row * columns;
				materials[idx] = PieceMaterial.getMaterial(Mathf.FloorToInt(Random.value * 5));
			}
		}
		//renderer.materials = materials;
	}
}
