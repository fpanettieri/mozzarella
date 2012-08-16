/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella source code.
===========================================================================
*/
#include "memory.h"

#include <assert.h>
#include <stdlib.h>

K_MemBuffer_t* K_MemAlloc( uint32_t size ) {
	assert( size > 0 );
	
	K_MemBuffer_t* buffer = ( K_MemBuffer_t* ) malloc( sizeof( K_MemBuffer_t ) );
	assert( buffer );
	
	buffer->size = size;
	buffer->offset = 0;
	buffer->mem = ( uint8_t* ) malloc( sizeof( uint8_t ) * size );
	assert( buffer->mem );
	
	return buffer;
}

void* K_LinearAlloc( K_MemBuffer_t* buffer, uint32_t size ) {
	assert( buffer );
	assert( size > 0 );
	
	uint32_t new_offset = buffer->offset + size;
	assert( new_offset <= buffer->size );

	void* ptr = buffer->mem + buffer->offset;
	buffer->offset = new_offset;

	return ptr;
}

void* K_StackAlloc( K_MemBuffer_t* buffer, uint32_t size, K_StackHandle_t* handle ) {
	assert( buffer );
	assert( size > 0 );
	assert( handle );
	
	const uint32_t current_offset = buffer->offset;
	assert( current_offset + size <= buffer->size );
	
	void* ptr = buffer->mem + current_offset;
	buffer->offset += size;
	*handle = current_offset;
	
	return ptr;
}

void K_StackSet( K_MemBuffer_t* buffer, K_StackHandle_t handle ) {
	assert( buffer );
	assert( handle > -1 && handle < buffer->offset );
	
	buffer->offset = handle;
}

void K_MemFree( K_MemBuffer_t** buffer ) {
	assert( *buffer );
	assert( (*buffer)->mem );
	
	free( (*buffer)->mem );
	(*buffer)->mem = NULL;
	
	free( *buffer );
	(*buffer) = NULL;
}
