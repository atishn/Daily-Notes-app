//
//  HGDNData.h
//  Daily Notes
//  Model Data object, manages the collection of all notes including persistance.
//
//  Created by HUGE | Atish Narlawar on 8/9/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDefaultText @"New Note"
#define kAllNotes @"notes"
#define kDetailView @"showDetail"

@interface HGDNData : NSObject

+(NSMutableDictionary *)getAllNotes;
+(void)setCurrentKey:(NSString *)key;
+(NSString *) getCurrentKey;
+(void)setNoteForCurrentKey:(NSString *)note;
+(void)setNote:(NSString *)note forKey:(NSString *)key;
+(void)removeNoteForKey:(NSString *)key;
+(void)saveNotes;

@end
