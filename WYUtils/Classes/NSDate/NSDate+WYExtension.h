//
//  NSDate+WYExtension.h
//  WYBaseLib
//
//  Created by wyan assert on 08/01/2018.
//  Copyright © 2018 makeupopular.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WYExtension)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)wy_day;
- (NSUInteger)wy_month;
- (NSUInteger)wy_year;
- (NSUInteger)wy_hour;
- (NSUInteger)wy_minute;
- (NSUInteger)wy_second;
+ (NSUInteger)wy_day:(NSDate *)date;
+ (NSUInteger)wy_month:(NSDate *)date;
+ (NSUInteger)wy_year:(NSDate *)date;
+ (NSUInteger)wy_hour:(NSDate *)date;
+ (NSUInteger)wy_minute:(NSDate *)date;
+ (NSUInteger)wy_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)wy_daysInYear;
+ (NSUInteger)wy_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)wy_isLeapYear;
+ (BOOL)wy_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)wy_weekOfYear;
+ (NSUInteger)wy_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)wy_formatYMD;
+ (NSString *)wy_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)wy_weeksOfMonth;
+ (NSUInteger)wy_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)wy_begindayOfMonth;
+ (NSDate *)wy_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)wy_lastdayOfMonth;
+ (NSDate *)wy_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)wy_dateAfterDay:(NSUInteger)day;
+ (NSDate *)wy_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)wy_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)wy_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)wy_offsetYears:(int)numYears;
+ (NSDate *)wy_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)wy_offsetMonths:(int)numMonths;
+ (NSDate *)wy_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)wy_offsetDays:(int)numDays;
+ (NSDate *)wy_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)wy_offsetHours:(int)hours;
+ (NSDate *)wy_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)wy_daysAgo;
+ (NSUInteger)wy_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)wy_weekday;
+ (NSInteger)wy_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)wy_dayFromWeekday;
+ (NSString *)wy_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)wy_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)wy_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)wy_dateByAddingDays:(NSUInteger)days;

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
+ (NSString *)wy_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)wy_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)wy_stringWithFormat:(NSString *)format;
+ (NSDate *)wy_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)wy_daysInMonth:(NSUInteger)month;
+ (NSUInteger)wy_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)wy_daysInMonth;
+ (NSUInteger)wy_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)wy_timeInfo;
+ (NSString *)wy_timeInfoWithDate:(NSDate *)date;
+ (NSString *)wy_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)wy_ymdFormat;
- (NSString *)wy_hmsFormat;
- (NSString *)wy_ymdHmsFormat;
+ (NSString *)wy_ymdFormat;
+ (NSString *)wy_hmsFormat;
+ (NSString *)wy_ymdHmsFormat;

@end
