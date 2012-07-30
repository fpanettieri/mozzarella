/*
===========================================================================
Copyright (C) 2012-2014 Gaming Fondue

This file is part of Mozzarella source code.
===========================================================================
*/
#include "command.h"

#include <assert.h>

#include "../kernel/memory.h"

S_Commands_t* S_CreateCommands( K_MemBuffer_t* mem ) {
	S_Commands_t* commands = ( S_Commands_t* ) K_LinearAlloc( mem, sizeof( S_Commands_t ) );
	commands->first = NULL;
	commands->current = NULL;
	commands->last = NULL;
	return commands;
}

void S_AddCommand( K_MemBuffer_t* mem, S_Commands_t* commands, S_CommandType_t type, S_CommandTime_t time ) {
	S_Command_t* command =  ( S_Command_t* ) K_LinearAlloc( mem, sizeof( S_Command_t ) );
	command->type = type;
	command->time = time;
	
	// The first command becomes first and last
	if( commands->current == NULL )  {
		command->prev = NULL;
		command->next = NULL;
	
	// Commands always are inserted next to the last executed/inserted command
	// Insert after current
	} else if( commands->current->time <= command->time ) {
		command->next = commands->current->next;
		commands->current->next = command;
		command->prev = commands->current;
		command->next->prev = command;		
	
	// Insert before current
	} else {
		command->prev = commands->current->prev;
		commands->current->prev = command;
		command->next = commands->current;
		command->prev->next = command;
	}
	
	// Check if the command is the first or last
	if( command->next == NULL )	{
		commands->last = command;
	}
	
	if( command->prev == NULL ) {
		commands->first = command;
	}
	
	// Each time a command is added, ot the time moves forward and backward
	// this pointer gets updated. This allows faster insertion and fetching
	commands->current = command;
}

void S_RemoveCommand( S_Commands_t* commands, S_CommandType_t type, S_CommandTime_t time ) {
	// FIXME[sn00py]: not implemented yet, as it mey not be needed
}

void S_DestroyCommands( K_MemBuffer_t* mem, S_Commands_t* commands ){
	// do nothing
}
