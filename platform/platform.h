/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella source code.

It provides a simple mechanism used to detect the current platform.
===========================================================================
*/
#ifndef PLATFORM_PLATFORM_H_INCLUDED
#define PLATFORM_PLATFORM_H_INCLUDED

#define PLATFORM_WINDOWS	1
#define PLATFORM_LINUX		2
#define PLATFORM_MACOS		3
#define PLATFORM_ANDROID	4
#define PLATFORM_IOS		5

#if defined(_WIN32)
 #define PLATFORM_ID		PLATFORM_WINDOWS
#elif defined(__ANDROID__)		// must come before __linux__ as Android also #defines __linux__
 #define PLATFORM_ID		PLATFORM_ANDROID
#elif defined(__linux__)
 #define PLATFORM_ID		PLATFORM_LINUX
#elif defined(__MACH__)
 #include <TargetConditionals.h>
 #if (TARGET_OS_IPHONE == 1)
  #define PLATFORM_ID		PLATFORM_IOS
 #else
  #define PLATFORM_ID		PLATFORM_MACOS
 #endif
#endif

#endif /* PLATFORM_PLATFORM_H_INCLUDED */
