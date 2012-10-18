using UnityEngine;
using System.Collections;

public class PieceLocker : MonoBehaviour, IEventListener
{
	// Dependencies
	private Grid grid;
	private PiecePool pool;
	private Timeline timeline;

	// Private / aux properties
	private Piece piece;
	private Vector3 pieceSize;
	private PieceEvent e;
	
	public void Awake()
	{
		Events.i.Register(MozEventType.PieceLock, this);
		grid = GetComponent<Grid>();
		pool = GetComponent<PiecePool>();
		timeline = GameObject.Find(GameObjectName.TIME).GetComponent<Timeline>();
	}
	
	public void Notify(MozEvent ev)
	{
		e = ev as PieceEvent;
		if(TimeMachine.rewind) {
			UnlockPiece(e);
		}
	}

	private void UnlockPiece(PieceEvent e)
	{
		grid.cells[e.column + e.row * grid.columns] = PieceType.Empty;
		piece = pool[e.id];
		grid.AddPiece(piece);
		timeline.Remove(e);
		// TODO: Play piece unlock sound
	}
}
