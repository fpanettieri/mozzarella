/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella platform abstraction layer.

It provides definitions for cross platform standard types.
If any value used here is not available in the target platform, we redefine
it here so it's transparent for the rest of the game.
===========================================================================
*/
#ifndef PLATFORM_TYPES_H_INCLUDED
#define PLATFORM_TYPES_H_INCLUDED

#include <stdint.h>
#include <stdbool.h>

#if !defined BYTE_DEFINED
typedef unsigned char byte_t;
#define BYTE_DEFINED 1
#endif

#ifndef NULL
#define NULL ((void *)0)
#endif

typedef float float32_t;
typedef double float64_t;

#endif /* PLATFORM_TYPES_H_INCLUDED */
