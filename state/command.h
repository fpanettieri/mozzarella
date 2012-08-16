/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella source code.
===========================================================================
*/
#ifndef STATE_COMMAND_H_INCLUDED
#define STATE_COMMAND_H_INCLUDED

#include "command_types.h"

#include "../platform/types.h"
#include "../kernel/memory.h"

/*
===========================================================================
  S_NULL_COMMAND
  
  Special null pointer used to determine empty nodes. Actually it's the
  same as a NULL, but with explicit typecast to ensure g++ won't complain.
===========================================================================
*/
#define S_NULL_COMMAND ((S_Command_t*)0)

/*
===========================================================================
  S_CommandTime_t
  
  Time format used to identify when commands are created.
===========================================================================
*/
typedef float32_t S_CommandTime_t;

/*
===========================================================================
  S_Command_t
  
  A command represents an interaction of the user with the game.
  Double linked list node.
===========================================================================
*/
typedef struct _S_Command_t {
	S_CommandType_t type;
	S_CommandTime_t time;
	struct _S_Command_t* prev;
	struct _S_Command_t* next;
} S_Command_t;

/*
===========================================================================
  S_Commands_t
  
  Time format used to detect command.
  Double linked list.
===========================================================================
*/
typedef struct _S_Commands_t {
	S_Command_t* first;
	S_Command_t* current;
	S_Command_t* last;
} S_Commands_t;

/*
===========================================================================
  S_CreateCommands
  
  Allocates a new double linked used to store commands
===========================================================================
*/
S_Commands_t* S_CreateCommands( K_MemBuffer_t* mem );

/*
===========================================================================
  S_AddCommand
  
  Adds a new command to the double linked list
===========================================================================
*/
void S_AddCommand( K_MemBuffer_t* mem, S_Commands_t* commands, 
	S_CommandType_t type, S_CommandTime_t time );

/*
===========================================================================
  S_RemoveCommand
  
  Removes a command from the list
===========================================================================
*/
void S_RemoveCommand( S_Commands_t* commands, S_CommandType_t type, 
	S_CommandTime_t time );

/*
===========================================================================
  S_DestroyCommands
  
  Deallocates the memory used by the commands list
  ( in the linear an buffer mem, it does nothing)
===========================================================================
*/
void S_DestroyCommands( K_MemBuffer_t* mem, S_Commands_t* commands );

#endif /* STATE_COMMAND_H_INCLUDED */
