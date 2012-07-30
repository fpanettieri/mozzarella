/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella source code.
===========================================================================
*/
#include "command.h"

#include <assert.h>

#include "../kernel/memory.h"

void S_CreateCommands( K_MemBuffer_t* mem, S_Commands_t* commands ) {
	
}

void S_AddCommand( K_MemBuffer_t* mem, S_Commands_t* commands, S_CommandType_t type, S_CommandTime_t time ) {

}

void S_RemoveCommand( S_Commands_t* commands, S_CommandType_t type, S_CommandTime_t time ) {

}

void S_DestroyCommands( K_MemBuffer_t* mem, S_Commands_t* commands ){
	// do nothing
}
