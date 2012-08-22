/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#ifndef STATE_GRID_H_INCLUDED
#define STATE_GRID_H_INCLUDED

#include "../kernel/types.h"
#include "../kernel/memory.h"

/**
 * Represents a single piece
 */
typedef struct _S_Piece_t {
    uint8_t color;
	bool falling;
	bool grouped;
	bool exploding;
} S_Piece_t;

/**
 * Represents the playable area. It's a simple MxN grid.
 */
typedef struct _S_Grid_t {
    S_Piece_t* cells;
	uint16_t size;
	uint8_t rows;
	uint8_t columns;
} S_Grid_t;

/**
 * Allocates and initialize a new grid and it's members.
 * grid must be == NULL
 */
S_Grid_t* S_CreateGrid( K_MemBuffer_t* mem, uint8_t rows, uint8_t columns );

/**
 * Deallocates the memory used by the grid
 * ( in linear | stack buffer implementations it does nothing ).
 */
void S_DestroyGrid( K_MemBuffer_t* mem, S_Grid_t* grid );

/**
 * Return a piece pointer in the given position
 */
S_Piece_t* S_GetPieceAt( S_Grid_t* grid, uint8_t row, uint8_t column );

/**
 * Print the grid for debug purposes
 */
void S_PrintGrid( S_Grid_t* grid );

#endif /* STATE_GRID_H_INCLUDED */
