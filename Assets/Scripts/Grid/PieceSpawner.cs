using UnityEngine;
using System.Collections;

public class PieceSpawner : MonoBehaviour, IEventListener
{
	private Grid grid;
	private Vector3 pieceSize;

	// Use this for initialization
	public void Start ()
	{
		Events.i.Register (MozEventType.PieceSpawn, this);
		
		grid = GetComponent<Grid>();
		MeshFilter filter = grid.piecePrefab.GetComponent<MeshFilter> ();
		pieceSize = filter.sharedMesh.bounds.size;
	}
	
	public void Notify (MozEvent ev)
	{
		if (ev.type != MozEventType.PieceSpawn) { return; }
		
		PieceSpawnEvent e = ev as PieceSpawnEvent;
		if( e.piece == PieceType.Empty ) { return; }
		
		GameObject piece = Instantiate(grid.piecePrefab) as GameObject;
		piece.transform.parent = grid.transform;
		piece.transform.localPosition = new Vector3 (e.column * pieceSize.x, grid.rows * pieceSize.y, 0);
		
		MeshRenderer renderer = piece.GetComponent<MeshRenderer> ();
		renderer.material = PieceMaterial.getMaterial (e.piece);
		
		Piece mozPiece = piece.GetComponent<Piece> ();
		mozPiece.type = e.piece;
		mozPiece.moving = true;
		grid.AddMovingPiece( mozPiece );
		
		// TODO: get next piece id, assign it to the event, if its -1
		// TODO: if time is going backwards, search and destroy the piece
	}
}
