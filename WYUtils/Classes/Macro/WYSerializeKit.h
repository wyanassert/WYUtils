//
//  WYSerializeKit.h
//  Pods
//
//  Created by wyan on 2019/11/15.
//

#ifndef WYSerializeKit_h
#define WYSerializeKit_h
#import <objc/runtime.h>

#define kWYSerialize_Coder_Decoder()     \
\
- (id)initWithCoder:(NSCoder *)coder    \
{   \
NSLog(@"%s",__func__);  \
Class cls = [self class];   \
while (cls != [NSObject class]) {   \
\
BOOL bIsSelfClass = (cls == [self class]);  \
unsigned int iVarCount = 0; \
unsigned int propVarCount = 0;  \
unsigned int sharedVarCount = 0;    \
Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL; \
objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount); \
sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;   \
\
for (int i = 0; i < sharedVarCount; i++) {  \
const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
NSString *key = [NSString stringWithUTF8String:varName];   \
id varValue = [coder decodeObjectForKey:key];   \
NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"]; \
if (varValue && [filters containsObject:key] == NO) { \
[self setValue:varValue forKey:key];    \
}   \
}   \
free(ivarList); \
free(propList); \
cls = class_getSuperclass(cls); \
}   \
return self;    \
}   \
\
- (void)encodeWithCoder:(NSCoder *)coder    \
{   \
NSLog(@"%s",__func__);  \
Class cls = [self class];   \
while (cls != [NSObject class]) {   \
\
BOOL bIsSelfClass = (cls == [self class]);  \
unsigned int iVarCount = 0; \
unsigned int propVarCount = 0;  \
unsigned int sharedVarCount = 0;    \
Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;  \
objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount); \
sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;   \
\
for (int i = 0; i < sharedVarCount; i++) {  \
const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
NSString *key = [NSString stringWithUTF8String:varName];    \
 \
id varValue = [self valueForKey:key];   \
NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"]; \
if (varValue && [filters containsObject:key] == NO) { \
[coder encodeObject:varValue forKey:key];   \
}   \
}   \
free(ivarList); \
free(propList); \
cls = class_getSuperclass(cls); \
}   \
}


#define kWYSerialize_Copy_With_Zone()  \
\
  \
- (id)copyWithZone:(NSZone *)zone   \
{   \
NSLog(@"%s",__func__);  \
id copy = [[[self class] allocWithZone:zone] init];    \
Class cls = [self class];   \
while (cls != [NSObject class]) {  \
 \
BOOL bIsSelfClass = (cls == [self class]);  \
unsigned int iVarCount = 0; \
unsigned int propVarCount = 0;  \
unsigned int sharedVarCount = 0;    \
Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;  \
objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);  \
sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;   \
\
for (int i = 0; i < sharedVarCount; i++) {  \
const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
NSString *key = [NSString stringWithUTF8String:varName];    \
  \
id varValue = [self valueForKey:key];   \
NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"]; \
if (varValue && [filters containsObject:key] == NO) { \
[copy setValue:varValue forKey:key];    \
}   \
}   \
free(ivarList); \
free(propList); \
cls = class_getSuperclass(cls); \
}   \
return copy;    \
}


#define kWYSerialize_Description() \
\
\
- (NSString *)description   \
{   \
NSString  *despStr = @"";   \
Class cls = [self class];   \
while (cls != [NSObject class]) {   \
\
BOOL bIsSelfClass = (cls == [self class]);  \
unsigned int iVarCount = 0; \
unsigned int propVarCount = 0;  \
unsigned int sharedVarCount = 0;    \
Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;  \
objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount); \
sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;   \
\
for (int i = 0; i < sharedVarCount; i++) {  \
const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
NSString *key = [NSString stringWithUTF8String:varName];    \
 \
id varValue = [self valueForKey:key];   \
NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"]; \
if (varValue && [filters containsObject:key] == NO) { \
despStr = [despStr stringByAppendingString:[NSString stringWithFormat:@"%@: %@\n", key, varValue]]; \
}   \
}   \
free(ivarList); \
free(propList); \
cls = class_getSuperclass(cls); \
}   \
return despStr; \
}

/* 归档 */
#define kWYSerialize_Archive(__objToBeArchived__, __key__, __filePath__)    \
\
NSMutableData *data = [NSMutableData data]; \
NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];   \
[archiver encodeObject:__objToBeArchived__ forKey:__key__];    \
[archiver finishEncoding];  \
[data writeToFile:__filePath__ atomically:YES]


/* 解归档 */
#define kWYSerialize_Unarchive(__objToStoreData__, __key__, __filePath__)   \
NSMutableData *dedata = [NSMutableData dataWithContentsOfFile:__filePath__]; \
NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dedata];  \
__objToStoreData__ = [unarchiver decodeObjectForKey:__key__];  \
[unarchiver finishDecoding]


#endif /* WYSerializeKit_h */
