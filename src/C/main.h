#ifndef MAIN_H
#define MAIN_H
#include "gbafe.h"

// Vanilla stuff.
// From decomp.
struct DifficultyMenuSpritesProc {
  /* 00 */ PROC_HEADER;
  /* 29 */ u8 cursorToMove : 1;
  /* 29 */ u8 cursorMoving : 1;
  /* 2A */ u8 timer;
  /* 2B */ u8 currentlySelected;
  /* 2C */ s16 xCursor;
  /* 2E */ s16 yCursor;
  /* 30 */ u16 unk_30;
  /* 32 */ u16 unk_32;
  /* 34 */ u16 unk_34;
  /* 36 */ u16 unk_36;
  /* 38 */ s16 unk_38;
  /* 3A */ s16 unk_3a;
  /* 3C */ s16 cursorMoveTimer;
  
  // Custom, new vars.
  /* 3E */ s16 xOption;
};

// From decomp.
struct DifficultyMenuProc {
  /* 00 */ PROC_HEADER;
  /* 2C */ int unk_2c;
  /* 30 */ u8 selectedDifficulty;
  /* 34 */ struct DifficultyMenuSpritesProc* spritesProc;
  /* 38 */ struct TextHandle difficultyText[5];
  
  // Custom, new vars.
  /* 60 */ u8 swappingModes;
  /* 61 */ u8 swappingModeTimer;
  /* 62 */ u8 swappingOut;
  /* 63 */ u8 difficultyType;   // Easy/Normal/Difficult is one type, Classic/Iron is another type.
};

// Difficulty types.
enum {
  IMM_EASYNORMALDIFFICULT = 0,
  IMM_CLASSICIRON = 1
};

struct DifficultyCursorMove {
  /* 00 */ s8 x;
  /* 01 */ s8 y;
  /* 02 */ u16 unk_2;
};
extern const struct DifficultyCursorMove difficultyCursorMove[3]; //! FE8U = 0x08A209FC
extern const struct DifficultyCursorMove IMM_difficultyCursorMove[2]; // Custom.

// From decomp. Also member of ChapterState in chapterdata.h.
struct PlaySt_OptionBits {
  // option bits
  u32 unitColor:1; // 1
  u32 disableTerrainDisplay:1; // 1
  u32 unitDisplayType:2; // 2
  u32 autoCursor:1; // 1
  u32 textSpeed:2;
  u32 gameSpeed:1; // 1

  u32 disableBgm:1; // 1
  u32 disableSoundEffects:1; // 1
  u32 windowColor:2;
  u32 unk41_5:1; // 1
  u32 unk41_6:1; // unk
  u32 disableAutoEndTurns:1; // 1
  u32 noSubtitleHelp:1; // 1

  u32 disableGoalDisplay:1; // unk
  u32 animationType:2; // 2
  u32 battleForecastType:2; // 2
  u32 controller:1; // 1
  u32 rankDisplay:1; // unk

  u32 debugControlRed:2; // 2 (!)
  u32 debugControlGreen:2; // 2
  u32 unk43_4:5; // unk

  u8  unk44[0x48 - 0x44];
} BITPACKED;

extern u8 gUnknown_02000940[4];
extern u8 gUnknown_02000944[4];
extern struct PlaySt_OptionBits gUnknown_02000948[4];

const int GetValueFromEasingFunction(u8 rateFunction, int startX, int endX, u32 currentT, u32 endT); //! FE8U = 0x8012DCC;

extern const int GetLastUsedGameSaveSlot(); //! FE8U = 0x80A4DA0
extern const u8 SaveMetadata_CheckId(int slot); //! FE8U = 0x80A5218
extern const void LoadSavedChapterState(int slot, ChapterState* PlaySt); //! FE8U = 0x80A522C

extern const void loadDifficultyPal(int config, int slot); //! FE8U = 0x080895B4
extern const void savemenu_SetDifficultyChoice(int difficulty, int unk_1); //! FE8U = 0x080AA52C
extern const void DrawDifficultyModeText(struct DifficultyMenuProc* proc); //! FE8U = 0x080ABFE0
extern const void DrawDifficultyMenuCursor(struct DifficultyMenuSpritesProc* proc); //! FE8U = 0x080AC418
extern const void DifficultyMenuSelectedPaletteLoop(u8 frameMaybe, u8 selectedIdx); //! FE8U = 0x080AC4F8
extern const void updateDifficultySprites(struct DifficultyMenuSpritesProc* proc, int cursorXMove, int cursorYMove); //! FE8U = 0x080AC680

extern const int FadeInExists();
extern const int FadeOutExists();
extern const void NewFadeIn(int fadeRate);
extern const void NewFadeOut(int fadeRate);

extern const struct ProcInstruction gProc_SaveMenu[]; //! FE8U = 0x08A200B8

// New stuff.
const void IMM_loadPals(u8 slot);

const void IMM_difficultySelectInit(struct DifficultyMenuProc* proc);
const void IMM_modeSelectKeyHandler(struct DifficultyMenuProc* proc);
const void IMM_swapSpritesInit(struct DifficultyMenuProc* proc);
const void IMM_swapSpritesLoop(struct DifficultyMenuProc* proc);

const void IMM_drawDifficultySpritesInit(struct DifficultyMenuSpritesProc * proc);
const void IMM_drawDifficultySpritesLoop(struct DifficultyMenuSpritesProc * proc);
const void IMM_swapSprites(struct DifficultyMenuProc* proc);

const struct ProcInstruction IMM_difficultySelectProc[];

const void IMM_findInitialCopyDataSave(Proc* saveMenuProc);
const s8 IMM_copyDataSlotMove(Proc* saveMenuProc, u8 previous, s8 direction);
const u8 IMM_saveMenuModifySaveSlot(u8 slot, int flag, int direction);

extern ObjData IMM_classicTextOAM;
extern ObjData IMM_ironTextOAM;

#endif // MAIN_H