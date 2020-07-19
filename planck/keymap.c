#include "planck.h"
#include "action_layer.h"
#include "audio.h"

// TODO workman is kind of broken

// Key aliases for legibility
#define _______ KC_TRNS
#define ___x___ KC_NO

#define GOBACK_ TO(BASE_QWERTY_LAYER)

// Shortcut aliases
#define SC_RENAME                 S(KC_F6)
#define SC_COMMENT_LINE           LCTL(KC_SLSH)
#define SC_SYNTAX_AWARE_SELECTION LCTL(KC_UP)
#define SC_FIND_ACTION            LCTL(S(KC_A))
#define SC_COMPLETE_STATEMENT     LCTL(S(KC_ENT))
#define SC_QUICK_DOCUMENTATION    LCTL(KC_Q)
#define SC_SURROUND_WITH          LCTL(LALT(KC_T))
#define SC_OVERRIDE               LCTL(KC_O)
#define SC_EXTRACT_VARIABLE       LCTL(LALT(KC_V))
#define SC_SETTINGS               LCTL(LALT(KC_S))
#define SC_COMMIT                 LCTL(KC_K)
#define SC_VSPLIT                 LCTL(LALT(KC_5))
#define SC_HSPLIT                 LCTL(LALT(KC_QUOT))
#define SC_UNSPLIT                LALT(KC_D)
#define SC_UNSPLIT_ALL            LALT(S(KC_D))
#define SC_NEXT_SPLITTER          LALT(KC_T)
#define SC_DEBUG                  S(KC_F9)
#define SC_RUN                    S(KC_F10)
#define SC_SHOW_ANCESTRY          LCTL(KC_F12)
#define SC_RESUME_PROGRAM         KC_F9
#define SC_STEP_OVER              KC_F8
#define SC_STEP_INTO              KC_F7
#define SC_FORCE_STEP_INTO        LALT(S(KC_F7))
#define SC_STEP_OUT               S(KC_F8)
#define SC_GENERATE               LALT(KC_INSERT)

// Lighting config
#define LIGHT_REACTIVE_ATTN       125
#define LIGHT_BORED_TIMEOUT        60
#define LIGHT_SLEEP_TIMEOUT      1200
#define LIGHT_BORED_EFFECT_TICK   100

extern keymap_config_t keymap_config;

static uint32_t keypress_timer;

#define DS(V, S) float V[][2] = SONG(S);
DS(song_qwerty,          QWERTY_SOUND)
DS(song_workman,         COLEMAK_SOUND)
#undef DS

// Keymap layers
enum planck_layers {
  BASE_QWERTY_LAYER,
  BASE_WORKMAN_LAYER,
  LOWER_LAYER,
  RAISE_LAYER,
  NAV_LAYER,
  KEYBOARD_LAYER,
  SHORTCUT_LAYER,
  EXTRA_LAYER,
  LAYER_LAYER,
};

#define MOMENTARY_LAYER_ON (IS_LAYER_ON(LOWER_LAYER)||IS_LAYER_ON(RAISE_LAYER)||IS_LAYER_ON(NAV_LAYER)||IS_LAYER_ON(KEYBOARD_LAYER)||IS_LAYER_ON(SHORTCUT_LAYER)||IS_LAYER_ON(EXTRA_LAYER)||IS_LAYER_ON(LAYER_LAYER))

// Custom key codes
enum planck_keycodes {
  QWERTY = SAFE_RANGE,
  WORKMAN,
  LOWER,
  RAISE,

  // PHP stuff
  SKC_RETURN,
  SKC_ARROW,
  SKC_DOUBLE_ARROW,
  SKC_PUBLIC,
  SKC_PROTECTED,
  SKC_PRIVATE,
  SKC_ABSTRACT,
  SKC_STATIC,
  SKC_FINAL,
  SKC_FUNCTION,
  SKC_NAMESPACE,
  SKC_CLASS,

  // Go stuff
  SKC_FUNC,
  SKC_DEFER,
  SKC_INTERFACE,
  SKC_CHAN,
  SKC_RANGE,
  SKC_NE,
  SKC_ASSIGN,
  SKC_ERRNE,
  SKC_IFE,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  /* Base layer (Qwerty)
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │ TAB │  Q  │  W  │  E  │  R  │  T  │  Y  │  U  │  I  │  O  │  P  │SCL '│
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   * Tap for Esc -- │ CTL │  A  │  S  │  D  │  F  │  G  │  H  │  J  │  K  │  L  │; Nav│ CTL │ -- Tap for Enter
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *   Tap for ( -- │SHIFT│  Z  │  X  │  C  │  V  │  B  │  N  │  M  │  ,  │  .  │  /  │SHIFT│ -- Tap for )
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *   Tap for [ -- │ EXL │HYPER│ ALT │ WIN │LOWER│   Space   │RAISE│ WIN │ ALT │ MEH │LAYER│ -- Tap for ]
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [BASE_QWERTY_LAYER] = {
    {KC_TAB,                   KC_Q,    KC_W,    KC_E,    KC_R,  KC_T,   KC_Y,   KC_U,  KC_I,    KC_O,    KC_P,                   LT(SHORTCUT_LAYER, KC_QUOT)},
    {LCTL_T(KC_ESC),           KC_A,    KC_S,    KC_D,    KC_F,  KC_G,   KC_H,   KC_J,  KC_K,    KC_L,    LT(NAV_LAYER, KC_SCLN), RCTL_T(KC_ENT)             },
    {KC_LSPO,                  KC_Z,    KC_X,    KC_C,    KC_V,  KC_B,   KC_N,   KC_M,  KC_COMM, KC_DOT,  KC_SLSH,                KC_RSPC                    },
    {LT(EXTRA_LAYER, KC_LBRC), KC_HYPR, KC_LALT, KC_LGUI, LOWER, KC_SPC, KC_SPC, RAISE, KC_RGUI, KC_RALT, KC_MEH,                 LT(LAYER_LAYER, KC_RBRC)   }
  },

  /* Base layer (Workman)
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │     │  Q  │  D  │  R  │  W  │  B  │  J  │  F  │  U  │  P  │  ;  │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │  A  │  S  │  H  │  T  │  G  │  Y  │  N  │  E  │  O  │I Nav│     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │  Z  │  X  │  M  │  C  │  V  │  K  │  L  │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │           │     │     │     │     │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [BASE_WORKMAN_LAYER] = {
    {_______, KC_Q,    KC_D,    KC_R,    KC_W,    KC_B,    KC_J,    KC_F,    KC_U,    KC_P,    KC_SCLN,             _______},
    {_______, KC_A,    KC_S,    KC_H,    KC_T,    KC_G,    KC_Y,    KC_N,    KC_E,    KC_O,    LT(NAV_LAYER, KC_I), _______},
    {_______, KC_Z,    KC_X,    KC_M,    KC_C,    KC_V,    KC_K,    KC_L,    _______, _______, _______,             _______},
    {_______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,             _______}
  },

  /* Numeric (LOWER) layer
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │  =  │ F1  │ F2  │ F3  │ F4  │ F5  │ F6  │ F7  │ F8  │ F9  │ F10 │  -  │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │ CTL │  1  │  2  │  3  │  4  │  5  │  6  │  7  │  8  │  9  │  0  │ CTL │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │SHIFT│  -  │  =  │  `  │  \  │  [  │  ]  │     │  ,  │  .  │  /  │SHIFT│
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │  {  │     │ ALT │ WIN │     │ Backspace │     │ WIN │ ALT │     │  }  │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [LOWER_LAYER] = {
    {KC_EQL,     KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,     KC_F6,     KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_MINS   },
    {KC_LCTRL,   KC_1,    KC_2,    KC_3,    KC_4,    KC_5,      KC_6,      KC_7,    KC_8,    KC_9,    KC_0,    KC_RCTRL  },
    {KC_LSHIFT,  KC_MINS, KC_EQL,  KC_GRV,  KC_BSLS, KC_LBRC,   KC_RBRC,   ___x___, KC_COMM, KC_DOT,  KC_SLSH, KC_RSHIFT },
    {S(KC_LBRC), _______, KC_LALT, KC_LGUI, GOBACK_, KC_BSPACE, KC_BSPACE, _______, KC_RGUI, KC_RALT, ___x___, S(KC_RBRC)}
  },

  /* Symbol (RAISE) layer
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │  +  │ F11 │ F12 │ F13 │ F14 │ F15 │ F16 │ F17 │ F18 │ F19 │ F20 │  _  │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │ ESC │  !  │  @  │  #  │  $  │  %  │  ^  │  &  │  *  │  '  │  "  │ RET │ \
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤  |-- Mostly shifted version
   *                │  (  │  _  │  +  │  ~  │  |  │  {  │  }  │     │  ,  │  .  │  /  │  )  │ /    of lower layer
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │  {  │     │     │     │     │  Delete   │     │     │     │     │  }  │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [RAISE_LAYER] = {
    {KC_PLUS,    KC_F11,  KC_F12,  KC_F13,  KC_F14,  KC_F15,     KC_F16,     KC_F17,  KC_F18,  KC_F19,  KC_F20,     KC_UNDS   },
    {KC_ESC,     S(KC_1), S(KC_2), S(KC_3), S(KC_4), S(KC_5),    S(KC_6),    S(KC_7), S(KC_8), KC_QUOT, S(KC_QUOT), KC_ENT    },
    {KC_LPRN,    KC_UNDS, KC_PLUS, KC_TILD, KC_PIPE, S(KC_LBRC), S(KC_RBRC), ___x___, KC_COMM, KC_DOT,  KC_SLSH,    KC_RPRN   },
    {S(KC_LBRC), _______, _______, _______, _______, KC_DEL,     KC_DEL,     GOBACK_, _______, _______, ___x___,    S(KC_RBRC)}
  },

  /* Directional navigation (NAV) layer
   *
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │     │ DL  │ DR  │     │ F4  │  +  │  -  │     │     │     │     │  *  │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │ ESC │     │Home │PgUp │PgDn │ End │  ←  │  ↓  │  ↑  │  →  │     │ RET │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │     │     │     │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │   Space   │     │     │     │     │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [NAV_LAYER] = {
    {___x___, RGUI(RCTL(KC_LEFT)), RGUI(RCTL(KC_RIGHT)), ___x___, KC_F4,   KC_PLUS,  KC_MINUS,  ___x___, ___x___, ___x___, ___x___, KC_ASTERISK},
    {KC_ESC,  ___x___,             KC_HOME,              KC_PGUP, KC_PGDN, KC_END,   KC_LEFT,   KC_DOWN, KC_UP,   KC_RGHT, GOBACK_, ___x___    },
    {___x___, ___x___,             ___x___,              ___x___, ___x___, ___x___,  ___x___,   ___x___, ___x___, ___x___, ___x___, ___x___    },
    {___x___, _______,             _______,              _______, ___x___, KC_SPACE, KC_SPACE,  ___x___, _______, _______, _______, _______    }
  },

  /* Keyboard settings (KEYBOARD) layer
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │Vol+ │     │     │     │     │Mus +│Mus -│ F21 │ F22 │ F23 │ F24 │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │Vol- │     │     │     │     │SLCK │  ←  │  ↓  │  ↑  │  →  │Pause│ INS │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │Mute │QWERT│WRKMN│     │MSEL │Prev │Next │     │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │PSCR │     │     │SYSRQ│     │   Play    │     │Mail │Calc │ App │MYCM │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [KEYBOARD_LAYER] = {
    {KC_VOLU, ___x___, ___x___, ___x___,   ___x___, MU_ON,   MU_OFF,  KC_F21,  KC_F22,  KC_F23,  KC_F24,     ___x___},
    {KC_VOLD, ___x___, ___x___, ___x___,   ___x___, KC_SLCK, KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, KC_PAUSE,   KC_INS },
    {KC_MUTE, QWERTY,  WORKMAN, ___x___,   KC_MSEL, KC_MPRV, KC_MNXT, ___x___, ___x___, ___x___, ___x___,    ___x___},
    {KC_PSCR, ___x___, ___x___, KC_SYSREQ, GOBACK_, KC_MPLY, KC_MPLY, GOBACK_, KC_MAIL, KC_CALC, KC_APP,     KC_MYCM}
  },

  /* Shortcut (SHORTCUT) layer
   *
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │ ->  │ Pub │Prot │Priv │Func │Chan │     │     │     │Debug│ RUN │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │ =>  │Abstr│Stat │Final│ :=  │Range│Defer│ !=  │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │ Ret │Funct│ Ns  │Class│Intrf│errne│ ife │     │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │ RES │ SO  │ SI  │ FSI │SOUT │   Space   │ GEN │     │     │     │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [SHORTCUT_LAYER] = {
    {SKC_ARROW,         SKC_PUBLIC,   SKC_PROTECTED, SKC_PRIVATE,        SKC_FUNC,      SKC_CHAN,  ___x___,   ___x___,     ___x___, SC_DEBUG,  SC_RUN,  GOBACK_},
    {SKC_DOUBLE_ARROW,  SKC_ABSTRACT, SKC_STATIC,    SKC_FINAL,          SKC_ASSIGN,    SKC_RANGE, SKC_DEFER, SKC_NE,      ___x___, ___x___,   ___x___, ___x___},
    {SKC_RETURN,        SKC_FUNCTION, SKC_STATIC,    SKC_CLASS,          SKC_INTERFACE, SKC_ERRNE, SKC_IFE,   ___x___,     ___x___, ___x___,   ___x___, ___x___},
    {SC_RESUME_PROGRAM, SC_STEP_OVER, SC_STEP_INTO,  SC_FORCE_STEP_INTO, SC_STEP_OUT,   KC_SPC,    KC_SPC,    SC_GENERATE, ___x___, ___x___,   ___x___, _______}
  },

  /* Extra (EXTRA) layer
   *
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │ F4  │MS B2│MS Up│MS B1│MS WU│     │     │NLCK │  7  │  8  │  9  │  -  │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │ CTL │MS L │MS Dn│MS R │MS WD│     │     │  =  │  4  │  5  │  6  │  +  │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │Shift│MS WL│MS B3│MS WR│MS B4│     │     │  /  │  1  │  2  │  3  │ ENT │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │ Alt │ WIN │MS B5│           │  *  │  0  │  ,  │  .  │ ENT │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [EXTRA_LAYER] = {
    {KC_F4,   KC_BTN2, KC_MS_U, KC_BTN1, KC_WH_U, ___x___, ___x___, KC_NLCK, KC_P7, KC_P8,   KC_P9,   KC_PMNS},
    {KC_LCTL, KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_D, ___x___, ___x___, KC_PEQL, KC_P4, KC_P5,   KC_P6,   KC_PPLS},
    {KC_LSFT, KC_WH_L, KC_BTN3, KC_WH_R, KC_BTN4, ___x___, ___x___, KC_PSLS, KC_P1, KC_P2,   KC_P3,   KC_PENT},
    {GOBACK_, ___x___, KC_LALT, KC_LGUI, KC_BTN5, ___x___, ___x___, KC_PAST, KC_P0, KC_PCMM, KC_PDOT, KC_PENT}
  },

  /* Layer (LAYER) layer
   *
   *                ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
   *                │     │     │     │     │     │     │     │     │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │     │     │     │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │     │     │     │     │     │     │     │
   *                ├─────┼─────┼─────┼─────┼─────┼─────┴─────┼─────┼─────┼─────┼─────┼─────┤
   *                │     │     │     │     │     │           │     │     │     │     │     │
   *                └─────┴─────┴─────┴─────┴─────┴───────────┴─────┴─────┴─────┴─────┴─────┘
   */
  [LAYER_LAYER] = {
    {___x___,         ___x___, ___x___, ___x___, ___x___,         ___x___, ___x___, ___x___,         ___x___, ___x___, ___x___,       TO(SHORTCUT_LAYER)},
    {___x___,         ___x___, ___x___, ___x___, ___x___,         ___x___, ___x___, ___x___,         ___x___, ___x___, TO(NAV_LAYER), ___x___           },
    {___x___,         ___x___, ___x___, ___x___, ___x___,         ___x___, ___x___, ___x___,         ___x___, ___x___, ___x___,       ___x___           },
    {TO(EXTRA_LAYER), ___x___, ___x___, ___x___, TO(LOWER_LAYER), ___x___, ___x___, TO(RAISE_LAYER), ___x___, ___x___, ___x___,       _______           }
  },

};

void matrix_init_user() {
  audio_init();
  enable_polyphony();
  backlight_init();
  keypress_timer = timer_read32();
}

void matrix_scan_user() {
  // TICKER(M, D): M: multiplier, D: divisor.
  //
  // A length of a beat is 100ms * multiplier * divisor. A beat
  // is split up into D parts, each part is 100ms*M long. The
  // TICKER() macro returns the current part of the beat.
  #define TICKER(M, D) ((elapsed / (LIGHT_BORED_EFFECT_TICK * M)) % D)
  uint32_t elapsed = timer_elapsed32(keypress_timer);
  if (IS_LAYER_ON(LOWER_LAYER)) {
    switch TICKER(1, 20) {
      case 0:
        backlight_level(2);
        break;
      default:
        backlight_level(0);
        break;
    }
  } else if (IS_LAYER_ON(RAISE_LAYER)) {
    switch TICKER(1, 20) {
      case 0:
      case 2:
        backlight_level(2);
        break;
      default:
        backlight_level(0);
        break;
    }
  } else if (IS_LAYER_ON(NAV_LAYER)) {
    switch TICKER(5, 4) {
      case 0: backlight_level(0); break;
      case 1: backlight_level(1); break;
      case 2: backlight_level(2); break;
      case 3: backlight_level(1); break;
    }
  } else if (IS_LAYER_ON(KEYBOARD_LAYER)) {
    switch TICKER(1, 20) {
      case 0:
      case 2:
      case 4:
        backlight_level(2);
        break;
      default:
        backlight_level(0);
        break;
    }
  } else if (IS_LAYER_ON(SHORTCUT_LAYER)) {
    switch TICKER(1, 20) {
      case 0:
      case 1:
      case 5:
      case 7:
        backlight_level(2);
        break;
      default:
        backlight_level(0);
        break;
    }
  } else if (IS_LAYER_ON(EXTRA_LAYER)) {
    switch TICKER(5, 2) {
      case 0: backlight_level(1); break;
      default: backlight_level(0); break;
    }
  } else if (IS_LAYER_ON(LAYER_LAYER)) {
      backlight_level(1);
  } else {
     if (elapsed > (LIGHT_REACTIVE_ATTN * 2L)) {
       backlight_level(0);
     } else if (elapsed > LIGHT_REACTIVE_ATTN) {
       backlight_level(1);
     }
  }
  #undef TICKER
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  #define CMACRO(K, S) case K: if (record->event.pressed) { SEND_STRING(S); return false; } return true;

  if (record->event.pressed && !MOMENTARY_LAYER_ON) {
    backlight_level(2);
    keypress_timer = timer_read32();
  }

  switch (keycode) {
    case LOWER:
      if (record->event.pressed) {
        layer_on(LOWER_LAYER);
        update_tri_layer(LOWER_LAYER, RAISE_LAYER, KEYBOARD_LAYER);
      } else {
        layer_off(LOWER_LAYER);
        update_tri_layer(LOWER_LAYER, RAISE_LAYER, KEYBOARD_LAYER);
      }
      return false;
    case RAISE:
      if (record->event.pressed) {
        layer_on(RAISE_LAYER);
        update_tri_layer(LOWER_LAYER, RAISE_LAYER, KEYBOARD_LAYER);
      } else {
        layer_off(RAISE_LAYER);
        update_tri_layer(LOWER_LAYER, RAISE_LAYER, KEYBOARD_LAYER);
      }
      return false;

    case QWERTY:
      if (record->event.pressed) {
        set_single_persistent_default_layer(BASE_QWERTY_LAYER);
        stop_all_notes();
        PLAY_SONG(song_qwerty);
      }
      return false;
    case WORKMAN:
      if (record->event.pressed) {
        set_single_persistent_default_layer(BASE_WORKMAN_LAYER);
        stop_all_notes();
        PLAY_SONG(song_workman);
      }
      return false;

    CMACRO(SKC_RETURN,       "return ")
    CMACRO(SKC_ARROW,        "->")
    CMACRO(SKC_DOUBLE_ARROW, " => ")
    CMACRO(SKC_PUBLIC,       "public ")
    CMACRO(SKC_PROTECTED,    "protected ")
    CMACRO(SKC_PRIVATE,      "private ")
    CMACRO(SKC_ABSTRACT,     "abstract ")
    CMACRO(SKC_STATIC,       "static ")
    CMACRO(SKC_FINAL,        "final ")
    CMACRO(SKC_FUNCTION,     "function ")
    CMACRO(SKC_NAMESPACE,    "namespace ")
    CMACRO(SKC_CLASS,        "class ")
    CMACRO(SKC_FUNC,         "func ")
    CMACRO(SKC_DEFER,        "defer ")
    CMACRO(SKC_INTERFACE,    "interface ")
    CMACRO(SKC_CHAN,         "chan ")
    CMACRO(SKC_RANGE,        " := range ")
    CMACRO(SKC_NE,           "!=")
    CMACRO(SKC_ASSIGN,       ":=")
    CMACRO(SKC_ERRNE,        " err != nil {")
    CMACRO(SKC_IFE,          "if err := ")
  }

  return true;

  #undef CMACRO
}
