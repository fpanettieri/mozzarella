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
				type = grid.cells[j + i * grid.columns];
				if( type == PieceType.Empty) { continue; }
				SpawnPiece(j, i, grid.cells[j + i * grid.columns], false);
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
		SpawnPiece(e.column, e.row, e.piece, true);
		e.id = piece.id;
		grid.movingPieces.Add(piece);
	}

	private void SpawnPiece(int column, int row, int type, bool moving)
	{
		piece = pool.Pick();
		piece.transform.localPosition = new Vector3(column * pieceSize.x, row * pieceSize.y, 0);
		piece.renderer.material = PieceMaterial.getMaterial(type);
		piece.type = type;
		piece.column = column;
		piece.row = row;
		piece.moving = moving;
		piece.Enable();

		// If the first row is occupied, move it down
		// if it can't be moved down, dispatch game over
	}

	private void DestroyPiece(PieceSpawnEvent e)
	{
		grid.cells[e.column + e.row * grid.columns] = PieceType.Empty;
		pool.Release(e.id);
		piece = pool[e.id];
		piece.moving = false;
		piece.column = 0;
		piece.row = 0;
		piece.Disable();
		grid.movingPieces.Remove(piece);
	}
}
