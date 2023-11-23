#include <stdio.h>
#include "main.h"

// Based on 0x80ABD88.
const void IMM_loadPals(u8 slot) {
  int i;

  for (i = 0; i < 3; i++) {
    u32 flags = gUnknown_02000940[i] & 0x40 ? 4 : 0;

    if (!gUnknown_02000948[i].controller) {
      // Easy/Tutorial mode.
      if (gUnknown_02000944[i] == 1)
        flags = flags | 0x10;
      else if (gUnknown_02000944[i] == 2)
        flags = flags | 0x20;
      else if (gUnknown_02000944[i] == 3)
        flags = flags | 0x40;
    }
    else {
      if (gUnknown_02000944[i] == 3)
        flags = flags | 0x40;
      else
        flags = flags | 0x20;
    }
    
    // rankDisplay repurposed for Iron mode.
    if (gUnknown_02000948[i].rankDisplay) {
      flags = flags | 0x8;
    }
    
    if (i != slot) {
      flags = flags | 2;
    }
    loadDifficultyPal(flags | 1,    i * 2 + 0x1a);
    loadDifficultyPal(flags & 0xF7, i * 2 + 0x1b);    // Unset 0x8 for non-silver text.
  }

  EnablePaletteSync();
};

const void IMM_swapSpritesInit(struct DifficultyMenuProc* proc) {
  proc->swappingModes = TRUE;
  proc->swappingModeTimer = 0;
  proc->swappingOut = TRUE;
}

const void IMM_swapSpritesLoop(struct DifficultyMenuProc* proc) {
  u32 xStart = 8;
  u32 xEnd = -136;
  u8 easingfunction = 0;
  u32 endT = 7;
  proc->swappingModeTimer++;
  
  if (!proc->swappingOut) {
    xStart ^= xEnd;     // swaps xStart with xEnd.
    xEnd ^= xStart;
    xStart ^= xEnd;
    easingfunction = 1;
  }

  proc->spritesProc->xOption = (s16)GetValueFromEasingFunction(easingfunction, xStart, xEnd, proc->swappingModeTimer, endT);
  
  if (proc->swappingModeTimer >= endT) {
    if (proc->swappingOut) {
      if (proc->difficultyType == IMM_EASYNORMALDIFFICULT) {
        proc->difficultyType = IMM_CLASSICIRON;
        proc->spritesProc->yCursor = 48;
        
        // Load palettes for classic and iron.
        Proc* saveMenuProc = ProcFind(gProc_SaveMenu);
        u8 difficulty = *(u8*)(((u32)saveMenuProc)+0x2A);
        ApplyPalettes((u16*)((u32)(gPaletteBuffer)+0x2A0+(difficulty<<6)), 0x1B, 2);
      }
      else if (proc->difficultyType == IMM_CLASSICIRON) {
        proc->difficultyType = IMM_EASYNORMALDIFFICULT;
        proc->spritesProc->yCursor = 32;
      }
      proc->spritesProc->currentlySelected = 0;
      proc->selectedDifficulty = 0;
      DrawDifficultyModeText(proc);
    }
    else
      proc->swappingModes = FALSE;
    
    proc->swappingModeTimer = 0;
    proc->swappingOut ^= 1;    
    BreakProcLoop((Proc*)proc);
  }
};

// Based on 0x80AC3F4.
// Initialize new params.
void IMM_drawDifficultySpritesInit(struct DifficultyMenuSpritesProc * proc) {
    proc->cursorToMove = 0;
    proc->cursorMoving = 0;

    proc->timer = 0;
    proc->yCursor = 0;
    proc->xCursor = 0;
    
    // New params.
    proc->xOption = 8;
    
    // Load silver BG.
    ApplyPalettes((u16*)0x8A07C18, 0x1D, 2);
};

// Based on 0x80AC588.
// Allows for switching between first and second set of modes.
void IMM_drawDifficultySpritesLoop(struct DifficultyMenuSpritesProc * proc) {
  int i, j = 3;
  u8 incr = 0;
  ObjData* difficultySpriteTextArray[3];
  struct DifficultyMenuProc* difficultySelectProc = (struct DifficultyMenuProc*)proc->parent;
  proc->timer++;
  
  
  if (difficultySelectProc->difficultyType == IMM_EASYNORMALDIFFICULT) {
    difficultySpriteTextArray[0] = (ObjData*)0x8A20AD0;     // Easy
    difficultySpriteTextArray[1] = (ObjData*)0x8A20AE4;     // Normal
    difficultySpriteTextArray[2] = (ObjData*)0x8A20AF2;     // Difficult
    //j = 3;
    //incr = 0;
  }
  else if (difficultySelectProc->difficultyType == IMM_CLASSICIRON) {
    difficultySpriteTextArray[0] = &IMM_classicTextOAM;     // Classic
    difficultySpriteTextArray[1] = &IMM_ironTextOAM;        // Iron
    j = 2;
    incr = 3;
  }

  ObjInsert(4, 56, 4, (ObjData*)0x8A20AA0, 0x2000);     // BG
  ObjInsert(4, 56, 4, (ObjData*)0x8A20AAE, 0x4000);     // "Select Mode" Text.

  for (i = 0; i < j; i++) {
    s16 x = proc->xOption & 0x1FF;
    s16 y = (96 - j * 16) + i * 32;

    if (i == proc->currentlySelected)
      ObjInsert(4, x, y, (ObjData*)0x8A20AC2, (5 + (incr << 1) + (i * 2)) << 12);
    else
      ObjInsert(4, x, y, (ObjData*)0x8A20AC2, (6 + (incr << 1) + (i * 2)) << 12);

    ObjInsert(4, x, y, difficultySpriteTextArray[i], 0x4000);
  }

  

  DifficultyMenuSelectedPaletteLoop(proc->timer, proc->currentlySelected + incr);
  
  if (!difficultySelectProc->swappingModes)
    DrawDifficultyMenuCursor(proc);
};

// Initialize new custom vars.
const void IMM_difficultySelectInit(struct DifficultyMenuProc* proc) {
  proc->swappingModes = FALSE;
  proc->difficultyType = IMM_EASYNORMALDIFFICULT;
};

// Based on 0x80AC288.
const void IMM_modeSelectKeyHandler(struct DifficultyMenuProc* proc) {  

  // Move cursor.
  if (gKeyState.repeatedKeys & (KEY_DPAD_UP | KEY_DPAD_DOWN)) {
    proc->selectedDifficulty ^= 1;
    PlaySfx(0x66);
    proc->spritesProc->currentlySelected = proc->selectedDifficulty;
    updateDifficultySprites(proc->spritesProc,
                            IMM_difficultyCursorMove[proc->selectedDifficulty].x,
                            IMM_difficultyCursorMove[proc->selectedDifficulty].y);
    DrawDifficultyModeText(proc);
    return;
  }
  
  // Return to Easy/Normal/Difficult choice.
  if (gKeyState.pressedKeys & KEY_BUTTON_B) {
    proc->unk_2c = 0;
    PlaySfx(0x6b);
    BreakProcLoop((Proc*)proc);
    return;
  }
  
  if (gKeyState.pressedKeys & (KEY_BUTTON_A | KEY_BUTTON_START)) {
    proc->unk_2c = 0;
    PlaySfx(0x6a);
    Proc* saveMenuProc = Proc_Find(gProc_SaveMenu);
    u8* unk_3d = (u8*)((u32)(saveMenuProc)+0x3D);     // Store Classic/Iron here.
    
    switch (proc->selectedDifficulty) {
      case 0:
        *unk_3d = 0;
        break;
      case 1:
        *unk_3d = 1;
        break;
    }
    ProcGoto((Proc*)proc, 1);
    //return;
  }
};

// Based on ProcScr_NewGameDifficultySelect at 0xA20A10.
const struct ProcInstruction IMM_difficultySelectProc[] = {
  PROC_SET_NAME("IMM_difficultySelectProc"),
  PROC_SET_DESTRUCTOR(0x80AC079),             // DifficultySelect_OnEnd
  PROC_CALL_ROUTINE(0x80AD5B5),               // DisableAllGfx
  PROC_YIELD,
  
  PROC_CALL_ROUTINE(IMM_difficultySelectInit),
  PROC_CALL_ROUTINE(0x80AC1A9),               // Original DifficultySelect_Init
  PROC_SLEEP(1),

  PROC_CALL_ROUTINE(0x80AD5D9),               // EnableAllGfx
  PROC_CALL_ROUTINE_ARG(NewFadeIn, 8),
  PROC_WHILE_ROUTINE(FadeInExists),
  

PROC_LABEL(0),
  PROC_LOOP_ROUTINE(0x80AC289),               // DifficultySelect_Loop_KeyHandler
  // fallthrough

PROC_LABEL(3),
  PROC_CALL_ROUTINE(IMM_swapSpritesInit),
  PROC_LOOP_ROUTINE(IMM_swapSpritesLoop),
  PROC_LOOP_ROUTINE(IMM_swapSpritesLoop),
  PROC_SLEEP(1),
  PROC_LOOP_ROUTINE(IMM_modeSelectKeyHandler),
  PROC_CALL_ROUTINE(IMM_swapSpritesInit),
  PROC_LOOP_ROUTINE(IMM_swapSpritesLoop),
  PROC_LOOP_ROUTINE(IMM_swapSpritesLoop),
  PROC_SLEEP(1),
  PROC_GOTO(0),
  // fallthrough

PROC_LABEL(1),
  PROC_SLEEP(10),
  // fallthrough

PROC_LABEL(2),
  PROC_CALL_ROUTINE_ARG(NewFadeOut, 8),
  PROC_WHILE_ROUTINE(FadeOutExists),

  PROC_CALL_ROUTINE(0x80AC3DD),               // nullsub_64. Does nothing.

  PROC_END
};

/*
Based on 0x80895B4.
  config:
    - 0x01:  Set means dragon bar, unset means text (easy/normal etc.)
    - 0x02:  unset means light palette (selected), set means dark palette (unselected).
    - 0x04:  pal + 0x80. difficult (set) vs non-difficult.
    - 0x08:  pal + 0x140. Ignore 0x4, 0x10, 0x20 and 0x40 effects. Silver palette.
    - 0x10:  pal + 0x00. Set if tutorial. If set, ignore 0x4, 0x20 and 0x40 effects.
    - 0x20:  pal + 0x40. Set if prologue/Eirika. Mutually exclusive with the below.
    - 0x40:  pal + 0x40. Set if Ephraim mode. Mutually exclusive with the above.
    - 0x80:  If set, ignore all options except for 0x02. Ensures green palette during chapter status screen.
*/
/*
void IMM_loadDifficultyPal(int config, int palId) {
  u16* pal;
  
  // Figure out if bar (0x8A07AD8) or text (0x8A07C58).
  pal = (config & 1) ? (u16*)0x8A07AD8 : (u16*)0x8A07C58;

  if ((config & 0x80) == 0) {
    if ((config & 8) != 0) {
      pal = pal + 0xA0;
    } else {
      if ((config & 0x10) == 0) {
        if ((config & 0x20) != 0) {
          pal = pal + 0x20;
        }
        if ((config & 0x40) != 0) {
          pal = pal + 0x40;
        }
        if ((config & 4) != 0) {
          pal = pal + 0x40;
        }
      }
    }
  }

  if ((config & 2) != 0)
    pal = pal + 0x10;

  ApplyPalette(pal, palId);

  return;
}
*/