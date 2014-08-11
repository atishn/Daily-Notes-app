//
//  HGDNData.m
//  Daily Notes
//
//  Created by HUGE | Atish Narlawar on 8/9/14.
//  Copyright (c) 2014 HugeInc. All rights reserved.
//

#import "HGDNData.h"

@implementation HGDNData

static NSMutableDictionary *allNotes = nil;
static NSString *currentKey = nil;


+(NSMutableDictionary *)getAllNotes{
    if(allNotes == nil){
        
        // Case 1 : Use of User Defalts for storing data.
        
        allNotes = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:kAllNotes]];

        // Case 2 : Use of File System for storing data.
        //allNotes = [[NSMutableDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:[self filePath]]]; // Get empty dictionary incase file doesnt exist.
    }
    return allNotes;
}
+(void)setCurrentKey:(NSString *)key{
    
    currentKey = key;
}
+(NSString *) getCurrentKey{
    return currentKey;
}
+(void)setNoteForCurrentKey:(NSString *)note{
    
    [self setNote:note forKey:currentKey];
}
+(void)setNote:(NSString *)note forKey:(NSString *)key{
    [allNotes setObject:note forKey:key];
}
+(void)removeNoteForKey:(NSString *)key{
    [allNotes removeObjectForKey:key];
}

+(void)saveNotes{
    
    // Case 1 : Use of User Defalts for storing data.
    
    [[NSUserDefaults standardUserDefaults] setObject:allNotes forKey:kAllNotes];
    
    // Case 2 : Use of File System for storing data.
   // [allNotes writeToFile:[self filePath] atomically:YES];
}

// Case 2 : Use of File System for storing data.
+(NSString *)filePath {
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documents = [directories objectAtIndex:0];
    return [documents stringByAppendingPathComponent:kAllNotes];
}


@end
