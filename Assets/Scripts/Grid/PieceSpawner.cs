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
	private PieceEvent e;
	
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
	
	public void Notify(MozEvent ev)
	{
		e = ev as PieceEvent;
		if(TimeMachine.rewind) {
			DestroyPiece(e);
		} else {
			SpawnPiece(e);
		}
	}
	
	private void SpawnPiece(PieceEvent e)
	{
		SpawnPiece(e.column, grid.rows, e.piece, true);
		e.id = piece.id;
		grid.AddPiece(piece);
	}

	private void SpawnPiece(int column, int row, int type, bool moving)
	{
		piece = pool.Pick();
		piece.transform.localPosition = new Vector3(column * pieceSize.x, row * pieceSize.y, 0);
		piece.renderer.material = PieceMaterial.getMaterial(type);
		piece.type = type;
		piece.moving = moving;
		piece.Enable();
	}

	private void DestroyPiece(PieceEvent e)
	{
		pool.Release(e.id);
		piece = pool[e.id];
		piece.moving = false;
		piece.Disable();
		grid.RemovePiece(piece);
	}
}
