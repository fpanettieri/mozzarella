/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
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
