using UnityEngine;
using System.Collections;

public class PieceSpawner : MonoBehaviour, IEventListener
{
	// Dependencies
	private Grid grid;
	private PiecePool pool;

	// Private / aux properties
	private Piece piece;
	private Vector3 pieceSize;
	
	public void Awake()
	{
		Events.i.Register(MozEventType.PieceSpawn, this);
		
		grid = GetComponent<Grid>();
		pool = GetComponent<PiecePool>();
		
		MeshFilter filter = grid.piecePrefab.GetComponent<MeshFilter>();
		pieceSize = filter.sharedMesh.bounds.size;
	}

	// Populate grid with current level pieces
	public void Start()
	{
		int type = 0;
		for(int i = 0; i < grid.rows; i++) {
			for(int j = 0; j < grid.columns; j++) {
				type = grid.pieceTypes[j + i * grid.columns];
				if(type == PieceType.Empty) { continue;	}
				SpawnPiece(j, i, grid.pieceTypes[j + i * grid.columns], false);
			}
		}
	}
	
	public void Notify(MozEvent e)
	{
		if(TimeMachine.rewind) {
			DestroyPiece(e as PieceSpawnEvent);
		} else {
			SpawnPiece(e as PieceSpawnEvent);
		}
	}

	private void SpawnPiece(PieceSpawnEvent e)
	{
		if(grid.pieceTypes[e.column + e.row * grid.columns] != PieceType.Empty) {
			Events.i.Notify(new GameOverEvent());
			Debug.LogError("YOU LOSE!");
		}

		bool moving = grid.pieceTypes[e.column + (e.row - 1) * grid.columns] == PieceType.Empty;
		SpawnPiece(e.column, e.row, e.piece, moving);
		e.id = piece.id;

		if(moving) {
			grid.movingPieces.Add(piece);
		} else {
			grid.pieceTypes[e.column + e.row * grid.columns] = e.type;
			grid.pieceId[e.column + e.row * grid.columns] = piece.id;
		}
	}

	private void SpawnPiece(int column, int row, int type, bool moving)
	{
		piece = pool.Pick();
		piece.column = column;
		piece.row = row;
		piece.type = type;
		piece.moving = moving;
		piece.transform.localPosition = new Vector3(piece.column * pieceSize.x, piece.row * pieceSize.y, 0);
		piece.renderer.material = PieceMaterial.getMaterial(type);
		piece.Enable();
	}

	private void DestroyPiece(PieceSpawnEvent e)
	{
		grid.pieceTypes[e.column + e.row * grid.columns] = PieceType.Empty;
		pool.Release(e.id);
		piece = pool[e.id];
		piece.moving = false;
		piece.column = 0;
		piece.row = 0;
		piece.Disable();
		grid.movingPieces.Remove(piece);
	}
}
