#ifndef CONFIG_USER_H
#define CONFIG_USER_H

#include "config_common.h"

#define STARTUP_SONG SONG(PLANCK_SOUND)
//#define AUDIO_CLICKY
#define PREVENT_STUCK_MODIFIERS
#define AUDIO_VOICES
#define PERMISSIVE_HOLD
#define PITCH_STANDARD_A 880.0f

#undef DEBOUNCING_DELAY
#define DEBOUNCING_DELAY 15

#define NO_ACTION_ONESHOT

#define DISABLE_LEADER

#ifndef NO_DEBUG
#define NO_DEBUG
#endif // !NO_DEBUG
#if !defined(NO_PRINT) && !defined(CONSOLE_ENABLE)
#define NO_PRINT
#endif // !NO_PRINT

#endif
