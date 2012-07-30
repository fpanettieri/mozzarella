/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella source code.
===========================================================================
*/
#include "memory.h"

#include <stdlib.h>

void K_MemAlloc( uint32_t size, K_MemBuffer_t* buffer ) {
	buffer->size = size;
	buffer->offset = 0;
	buffer->mem = ( uint8_t* ) malloc( size );
}

void* K_LinearAlloc( K_MemBuffer_t* buffer, uint32_t size ) {
	if( buffer == NULL || size < 0 ) {
		return NULL;
	}

	uint32_t new_offset = buffer->offset + size;
	if( new_offset <= buffer->size ) {
		void* ptr = buffer->mem + buffer->offset;
		buffer->offset = new_offset;
		return ptr;
	} else {
		// TODO[sn00py]: if out of memory, fail and halt
	}
	
	return NULL;
}

void* K_StackAlloc( K_MemBuffer_t* buffer, uint32_t size, K_StackHandle_t* handle ) {
	if( buffer == NULL || size < 0 ) {
		return NULL;
	}

	const uint32_t current_offset = buffer->offset;
	if( current_offset + size <= buffer->size ) {
		void* ptr = buffer->mem + current_offset;
		buffer->offset += size;

		if( handle ) {
			*handle = current_offset;
		} else {
			// TODO[sn00py]: warn about null handle, probably a mistake
		}
		return ptr;
	} else {
		// TODO[sn00py]: if out of memory, fail and halt
	}

	return NULL;
}

void K_StackSet( K_MemBuffer_t* buffer, K_StackHandle_t handle ) {
	if( buffer == NULL || handle < 0 ) {
		return;
	} else if( handle < 0 || handle > buffer->offset ) {
		return;
	} else {
		buffer->offset = handle;
	}
}

void K_MemFree( K_MemBuffer_t* buffer ) {
	if ( buffer == NULL ) {
		return;
	}
	
	free( buffer->mem );
	buffer->mem = NULL;
}
