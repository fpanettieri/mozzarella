/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#ifndef KERNEL_MEMORY_H_INCLUDED
#define KERNEL_MEMORY_H_INCLUDED

#include "types.h"

/**
 * Stack top marker used to determine a specific position in memory
 */
typedef uint32_t K_StackHandle_t;

/**
 *  Memory buffer.
 *    total_size: Total size in bytes
 *	  offset: Current pointer offset
 *    mem: Pointer to buffer memory
 */
typedef struct _K_MemBuffer_t {
	uint32_t size;
	uint32_t offset;
	uint8_t* mem;
} K_MemBuffer_t;

/**
 * Creates a new K_MemBuffer_t which holds an allocated memory block of
 * "size" bytes
 *
 * The total number of allocated bytes is:
 * size + sizeof( K_MemBuffer_t )
 */
K_MemBuffer_t* K_MemAlloc( uint32_t size );

/**
 * Returns a non-aligned chunk of memory of the requested "size"
 * from the end of the buffer if it's possible. If not, a NULL pointer
 * is returned.
 *
 * The returned void pointer MUST be casted to the right type.
 */
void* K_LinearAlloc( K_MemBuffer_t* buffer, uint32_t size );

/**
  Behaves exactly like the K_LinearAlloc, but returns a pointer to the
  stack top BEFORE allocating the resource.
*/
void* K_StackAlloc( K_MemBuffer_t* buffer, uint32_t size, K_StackHandle_t* handle );

/**
 * Receives a pointer to a previous memory position, and moves the stack
 * pointer to that position.
 */
void K_StackSet( K_MemBuffer_t* buffer, K_StackHandle_t handle );

/**
 * Release the buffer memory, and the buffer pointer.
 */
void K_MemFree( K_MemBuffer_t** buffer );

#endif /* KERNEL_MEMORY_H_INCLUDED */
