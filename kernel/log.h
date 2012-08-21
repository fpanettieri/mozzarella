/*
===========================================================================
 Copyright (C) 2012-2014 Gaming Fondue

 This file is part of Mozzarella source code.
===========================================================================
*/
#ifndef KERNEL_LOG_H_INCLUDED
#define KERNEL_LOG_H_INCLUDED

#ifndef NDEBUG
	#include <stdio.h>
	#define DEBUG_LOG(log) printf("%s : %s\n", (__FUNCTION__), (log));
#else
	#define DEBUG_LOG(log)
#endif

#endif /* KERNEL_LOG_H_INCLUDED */
