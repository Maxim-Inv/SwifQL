//
//  ExtractFieldValue.swift
//  SwifQL
//
//  Created by Mihael Isaev on 29/10/2019.
//

public struct ExtractFieldValue {
    public let value: String
    
    /// Postgres specific
    /// for TIMESTAMP: The century
    /// for Interval: The number of centuries
    static var century: ExtractFieldValue { .init(value: "CENTURY") }
    
    /// Universal
    /// for TIMESTAMP: The day of the month (1-31)
    /// for Interval: The number of days
    static var day: ExtractFieldValue { .init(value: "DAY") }
    
    /// Postgres specific
    /// for TIMESTAMP: The decade that is the year divided by 10
    /// for Interval: Sames as TIMESTAMP
    static var decade: ExtractFieldValue { .init(value: "DECADE") }
    
    /// Postgres specific
    /// for TIMESTAMP: The day of week Sunday (0) to Saturday (6)
    /// for Interval: N/A
    static var dow: ExtractFieldValue { .init(value: "DOW") }
    
    /// Postgres specific
    /// for TIMESTAMP: The day of year that ranges from 1 to 366
    /// for Interval: N/A
    static var doy: ExtractFieldValue { .init(value: "DOY") }
    
    /// Postgres specific
    /// for TIMESTAMP: The number of seconds since 1970-01-01 00:00:00 UTC
    /// for Interval: The total number of seconds in the interval
    static var epoch: ExtractFieldValue { .init(value: "EPOCH") }
    
    /// Universal
    /// for TIMESTAMP: The hour (0-23)
    /// for Interval: The number of hours
    static var hour: ExtractFieldValue { .init(value: "HOUR") }
    
    /// Postgres specific
    /// for TIMESTAMP: Day of week based on ISO 8601 Monday (1) to Saturday (7)
    /// for Interval: N/A
    static var isoDow: ExtractFieldValue { .init(value: "ISODOW") }
    
    /// Postgres specific
    /// for TIMESTAMP: ISO 8601 week number of year
    /// for Interval: N/A
    static var isoYear: ExtractFieldValue { .init(value: "ISOYEAR") }
    
    /// Postgres specific
    /// for TIMESTAMP: The seconds field, including fractional parts, multiplied by 1000000
    /// for Interval: Sames as TIMESTAMP
    static var microseconds: ExtractFieldValue { .init(value: "MICROSECONDS") }
    
    /// Postgres specific
    /// for TIMESTAMP: The millennium
    /// for Interval: The number of millennium
    static var millenium: ExtractFieldValue { .init(value: "MILLENNIUM") }
    
    /// Postgres specific
    /// for TIMESTAMP: The seconds field, including fractional parts, multiplied by 1000
    /// for Interval: Sames as TIMESTAMP
    static var milliseconds: ExtractFieldValue { .init(value: "MILLISECONDS") }
    
    /// Universal
    /// for TIMESTAMP: The minute (0-59)
    /// for Interval: The number of minutes
    static var minute: ExtractFieldValue { .init(value: "MINUTE") }
    
    /// Universal
    /// for TIMESTAMP: Month, 1-12
    /// for Interval: The number of months, modulo (0-11)
    static var month: ExtractFieldValue { .init(value: "MONTH") }
    
    /// Universal
    /// for TIMESTAMP: Quarter of the year
    /// for Interval: The number of quarters
    static var quarter: ExtractFieldValue { .init(value: "QUARTER") }
    
    /// Universal
    /// for TIMESTAMP: The second
    /// for Interval: The number of seconds
    static var second: ExtractFieldValue { .init(value: "SECOND") }
    
    /// Postgres specific
    /// for TIMESTAMP: The timezone offset from UTC, measured in seconds
    /// for Interval: N/A
    static var timeZone: ExtractFieldValue { .init(value: "TIMEZONE") }
    
    /// Postgres specific
    /// for TIMESTAMP: The hour component of the time zone offset
    /// for Interval: N/A
    static var timeZoneHour: ExtractFieldValue { .init(value: "TIMEZONE_HOUR") }
    
    /// Postgres specific
    /// for TIMESTAMP: The minute component of the time zone offset
    /// for Interval: N/A
    static var timeZoneMinute: ExtractFieldValue { .init(value: "TIMEZONE_MINUTE") }
    
    /// Universal
    /// for TIMESTAMP: The number of the ISO 8601 week-numbering week of the year
    /// for Interval: N/A
    static var week: ExtractFieldValue { .init(value: "WEEK") }
    
    /// Universal
    /// for TIMESTAMP: The year
    /// for Interval: Sames as TIMESTAMP
    static var year: ExtractFieldValue { .init(value: "YEAR") }
    
    /// MySQL specific
    static var microsecond: ExtractFieldValue { .init(value: "MICROSECOND") }
    
    /// MySQL specific
    static var secondMicrosecond: ExtractFieldValue { .init(value: "SECOND_MICROSECOND") }
    
    /// MySQL specific
    static var minuteMicrosecond: ExtractFieldValue { .init(value: "MINUTE_MICROSECOND") }
    
    /// MySQL specific
    static var minuteSecond: ExtractFieldValue { .init(value: "MINUTE_SECOND") }
    
    /// MySQL specific
    static var hourMicrosecond: ExtractFieldValue { .init(value: "HOUR_MICROSECOND") }
    
    /// MySQL specific
    static var hourSecond: ExtractFieldValue { .init(value: "HOUR_SECOND") }
    
    /// MySQL specific
    static var hourMinute: ExtractFieldValue { .init(value: "HOUR_MINUTE") }
    
    /// MySQL specific
    static var dayMicrosecond: ExtractFieldValue { .init(value: "DAY_MICROSECOND") }
    
    /// MySQL specific
    static var daySecond: ExtractFieldValue { .init(value: "DAY_SECOND") }
    
    /// MySQL specific
    static var dayMinute: ExtractFieldValue { .init(value: "DAY_MINUTE") }
    
    /// MySQL specific
    static var dayHour: ExtractFieldValue { .init(value: "DAY_HOUR") }
    
    /// MySQL specific
    static var yearMonth: ExtractFieldValue { .init(value: "YEAR_MONTH") }
}
