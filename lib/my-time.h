#ifndef _MY_TIME_H_INCLUDED_
#define _MY_TIME_H_INCLUDED_

#include <stdint.h>

//@ #include "lib/predicates.gh"

/**
   A wrapper around the system function int time(void*). Returns the number of
   seconds since the Epoch (1970-01-01 00:00:00 +0000 (UTC)).
   @returns the number of seconds since Epoch.
*/
uint32_t current_time(void);
//@ requires last_time(?x);
//@ ensures x <= result &*& last_time(result);

#endif //_MY_TIME_H_INCLUDED_
