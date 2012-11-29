using UnityEngine;
using System.Collections;

public class PieceGrouper : MonoBehaviour, IEventListener
{
	// Dependencies
	private Grid grid;
	private PiecePool pool;

	// Private / aux properties
	private Piece piece;
	
	public void Awake()
	{
		Events.i.Register(MozEventType.PieceLock, this);
		grid = GetComponent<Grid>();
		pool = GetComponent<PiecePool>();
	}

	public void Notify(MozEvent e)
	{
		if(TimeMachine.rewind) {
			UngroupPiece(e as PieceLockEvent);
		} else {
			GroupPiece(e as PieceLockEvent);
		}
	}

	private void GroupPiece(PieceLockEvent e)
	{
		piece = pool[e.id];
		if(piece.row == 0){ return; }
		int spot = piece.column + piece.row * grid.columns;
		int down = piece.column + (piece.row - 1) * grid.columns;
		if (grid.pieceTypes[down] != piece.type){ return; }

		// left group
		if (piece.row > 0){
			int left = piece.column - 1 + piece.row * grid.columns;
			int diagLeft = piece.column - 1 + (piece.row - 1) * grid.columns;
			if(grid.pieceTypes[left] == piece.type && grid.pieceTypes[diagLeft] == piece.type) {
 				pool[grid.pieceId[spot]].groups++;
				pool[grid.pieceId[down]].groups++;
				pool[grid.pieceId[left]].groups++;
				pool[grid.pieceId[diagLeft]].groups++;
			}
			Debug.Log("left group");
		}

		if (piece.row < grid.columns - 1){
			int right = piece.column + 1 + piece.row * grid.columns;
			int diagRight = piece.column + 1 + (piece.row - 1) * grid.columns;
			if(grid.pieceTypes[right] == piece.type && grid.pieceTypes[diagRight] == piece.type) {
				pool[grid.pieceId[spot]].groups++;
				pool[grid.pieceId[down]].groups++;
				pool[grid.pieceId[right]].groups++;
				pool[grid.pieceId[diagRight]].groups++;
			}
			Debug.Log("right group");
		}
	}
	

	private void UngroupPiece(PieceLockEvent e)
	{
		piece = pool[e.id];
		piece.groups = 0;
		if(piece.row == 0){ return; }
		int down = piece.column + (piece.row - 1) * grid.columns;
		if (grid.pieceTypes[down] != piece.type){ return; }

		// left group
		if (piece.row > 0){
			int left = piece.column - 1 + piece.row * grid.columns;
			int diagLeft = piece.column - 1 + (piece.row - 1) * grid.columns;
			if(grid.pieceTypes[left] == piece.type && grid.pieceTypes[diagLeft] == piece.type) {
				pool[grid.pieceId[down]].groups--;
				pool[grid.pieceId[left]].groups--;
				pool[grid.pieceId[diagLeft]].groups--;
			}
		}

		// right group
		if (piece.row < grid.columns - 1){
			int right = piece.column + 1 + piece.row * grid.columns;
			int diagRight = piece.column + 1 + (piece.row - 1) * grid.columns;
			if(grid.pieceTypes[right] == piece.type && grid.pieceTypes[diagRight] == piece.type) {
				pool[grid.pieceId[down]].groups--;
				pool[grid.pieceId[right]].groups--;
				pool[grid.pieceId[diagRight]].groups--;
			}
		}
	}
}
