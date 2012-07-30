/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella source code.
===========================================================================
*/
#include "grid.h"

#include <assert.h>

#include "../kernel/log.h"
#include "../kernel/memory.h"

void S_CreateGrid( K_MemBuffer_t* mem, uint8_t rows, uint8_t columns, S_Grid_t* grid ) {
	
	grid->rows = rows;
	grid->columns = columns;
	grid->size = rows * columns;
	DEBUG_LOG("about to create cells");
	
	grid->cells = ( uint8_t* ) K_LinearAlloc( mem, sizeof( uint8_t ) * grid->size );
}

void S_DestroyGrid( K_MemBuffer_t* mem, S_Grid_t* grid ) {
	// do nothing
}
