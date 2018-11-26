//
//  NSDate+WYExtension.m
//  WYBaseLib
//
//  Created by wyan assert on 08/01/2018.
//  Copyright © 2018 makeupopular.com. All rights reserved.
//

#import "NSDate+WYExtension.h"

@implementation NSDate (WYExtension)

- (NSUInteger)wy_day {
    return [NSDate wy_day:self];
}

- (NSUInteger)wy_month {
    return [NSDate wy_month:self];
}

- (NSUInteger)wy_year {
    return [NSDate wy_year:self];
}

- (NSUInteger)wy_hour {
    return [NSDate wy_hour:self];
}

- (NSUInteger)wy_minute {
    return [NSDate wy_minute:self];
}

- (NSUInteger)wy_second {
    return [NSDate wy_second:self];
}

+ (NSUInteger)wy_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)wy_month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)wy_year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)wy_hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)wy_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)wy_second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)wy_daysInYear {
    return [NSDate wy_daysInYear:self];
}

+ (NSUInteger)wy_daysInYear:(NSDate *)date {
    return [self wy_isLeapYear:date] ? 366 : 365;
}

- (BOOL)wy_isLeapYear {
    return [NSDate wy_isLeapYear:self];
}

+ (BOOL)wy_isLeapYear:(NSDate *)date {
    NSUInteger year = [date wy_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)wy_formatYMD {
    return [NSDate wy_formatYMD:self];
}

+ (NSString *)wy_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%zd-%zd-%zd",[date wy_year],[date wy_month], [date wy_day]];
}

- (NSUInteger)wy_weeksOfMonth {
    return [NSDate wy_weeksOfMonth:self];
}

+ (NSUInteger)wy_weeksOfMonth:(NSDate *)date {
    return [[date wy_lastdayOfMonth] wy_weekOfYear] - [[date wy_begindayOfMonth] wy_weekOfYear] + 1;
}

- (NSUInteger)wy_weekOfYear {
    return [NSDate wy_weekOfYear:self];
}

+ (NSUInteger)wy_weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date wy_year];
    
    NSDate *lastdate = [date wy_lastdayOfMonth];
    
    for (i = 1;[[lastdate wy_dateAfterDay:-7 * i] wy_year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)wy_dateAfterDay:(NSUInteger)day {
    return [NSDate wy_dateAfterDate:self day:day];
}

+ (NSDate *)wy_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)wy_dateAfterMonth:(NSUInteger)month {
    return [NSDate wy_dateAfterDate:self month:month];
}

+ (NSDate *)wy_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)wy_begindayOfMonth {
    return [NSDate wy_begindayOfMonth:self];
}

+ (NSDate *)wy_begindayOfMonth:(NSDate *)date {
    return [self wy_dateAfterDate:date day:-[date wy_day] + 1];
}

- (NSDate *)wy_lastdayOfMonth {
    return [NSDate wy_lastdayOfMonth:self];
}

+ (NSDate *)wy_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self wy_begindayOfMonth:date];
    return [[lastDate wy_dateAfterMonth:1] wy_dateAfterDay:-1];
}

- (NSUInteger)wy_daysAgo {
    return [NSDate wy_daysAgo:self];
}

+ (NSUInteger)wy_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)wy_weekday {
    return [NSDate wy_weekday:self];
}

+ (NSInteger)wy_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)wy_dayFromWeekday {
    return [NSDate wy_dayFromWeekday:self];
}

+ (NSString *)wy_dayFromWeekday:(NSDate *)date {
    switch([date wy_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)wy_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)wy_isToday {
    return [self wy_isSameDay:[NSDate date]];
}

- (NSDate *)wy_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)wy_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)wy_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date wy_stringWithFormat:format];
}

- (NSString *)wy_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)wy_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)wy_daysInMonth:(NSUInteger)month {
    return [NSDate wy_daysInMonth:self month:month];
}

+ (NSUInteger)wy_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date wy_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)wy_daysInMonth {
    return [NSDate wy_daysInMonth:self];
}

+ (NSUInteger)wy_daysInMonth:(NSDate *)date {
    return [self wy_daysInMonth:date month:[date wy_month]];
}

- (NSString *)wy_timeInfo {
    return [NSDate wy_timeInfoWithDate:self];
}

+ (NSString *)wy_timeInfoWithDate:(NSDate *)date {
    return [self wy_timeInfoWithDateString:[self wy_stringWithDate:date format:[self wy_ymdHmsFormat]]];
}

+ (NSString *)wy_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self wy_dateWithString:dateString format:[self wy_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate wy_month] - [date wy_month]);
    int year = (int)([curDate wy_year] - [date wy_year]);
    int day = (int)([curDate wy_day] - [date wy_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate wy_month] == 1 && [date wy_month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self wy_daysInMonth:date month:[date wy_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate wy_day] + (totalDays - (int)[date wy_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate wy_month];
            int preMonth = (int)[date wy_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)wy_ymdFormat {
    return [NSDate wy_ymdFormat];
}

- (NSString *)wy_hmsFormat {
    return [NSDate wy_hmsFormat];
}

- (NSString *)wy_ymdHmsFormat {
    return [NSDate wy_ymdHmsFormat];
}

+ (NSString *)wy_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)wy_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)wy_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self wy_ymdFormat], [self wy_hmsFormat]];
}

- (NSDate *)wy_offsetYears:(int)numYears {
    return [NSDate wy_offsetYears:numYears fromDate:self];
}

+ (NSDate *)wy_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)wy_offsetMonths:(int)numMonths {
    return [NSDate wy_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)wy_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)wy_offsetDays:(int)numDays {
    return [NSDate wy_offsetDays:numDays fromDate:self];
}

+ (NSDate *)wy_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)wy_offsetHours:(int)hours {
    return [NSDate wy_offsetHours:hours fromDate:self];
}

+ (NSDate *)wy_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

@end
