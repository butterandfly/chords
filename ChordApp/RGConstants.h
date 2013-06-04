//
//  RGConstants.h
//  ChordApp
//
//  Created by Zero on 13-3-20.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#ifndef ChordApp_RGConstants_h
#define ChordApp_RGConstants_h

/*
typedef enum {
    kGoingChord = 0,
    kMissingChord
} QuestType;
 */

typedef enum {
    kQuestCateChordsProgression = 0,
    kQuestCateMissingChod
} QuestCategory;

// File Names
#define kFileChordsDataFile @"chords_data"

// User Defaulsts
#define kSettingQuestCategory @"questCategory"
#define kSettingChordsArray @"chords"

// Plist of chords_data
#define kPlistQuestCates @"questCategorys"
#define kPlistAllChords @"allChords"
#define kPlistQuestCatesText @"questCatesText"

#endif
