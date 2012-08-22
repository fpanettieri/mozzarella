/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#include "grid.h"

#include <assert.h>
#include <stdio.h>

#include "../kernel/memory.h"

 S_Grid_t* S_CreateGrid( K_MemBuffer_t* mem, uint8_t rows, uint8_t columns )
 {
	S_Grid_t* grid = ( S_Grid_t* ) K_LinearAlloc( mem, sizeof( S_Grid_t ) );
	grid->rows = rows;
	grid->columns = columns;
	grid->size = rows * columns;
	grid->cells = ( S_Piece_t* ) K_LinearAlloc( mem, sizeof( S_Piece_t ) * grid->size );
	return grid;
}

void S_DestroyGrid( K_MemBuffer_t* mem, S_Grid_t* grid ) {
	// do nothing
}

S_Piece_t* S_GetPieceAt( S_Grid_t* grid, uint8_t row, uint8_t column )
{
    assert( row < grid->rows );
    assert( column < grid->columns );
    return grid->cells + (row * grid->columns + column);
}

void S_PrintGrid( S_Grid_t* grid )
{
    uint8_t i, j;
    for( i = 0; i < grid->rows; i++ ) {
        for( j = 0; j < grid->columns; j++ ) {
            printf( "%d ", S_GetPieceAt( grid, i, j )->color );
        }
        printf("\n");
    }
}
