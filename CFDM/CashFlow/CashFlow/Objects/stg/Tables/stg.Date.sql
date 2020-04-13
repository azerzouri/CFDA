/* 
 * TABLE: stg.Date 
 */

CREATE TABLE stg.Date(
    Date_SK               int         IDENTITY(1,1),
    DateKey               int         NOT NULL,
    DateFull              date        NULL,
    DateFullName          char(11)    NULL,
    Year                  int         NOT NULL,
    Quarter               int         NOT NULL,
    QuarterKey            int         NOT NULL,
    QuarterShortName      char(2)     NOT NULL,
    QuarterFullName       char(6)     NOT NULL,
    Month                 int         NOT NULL,
    MonthKey              int         NOT NULL,
    MonthShortName        char(3)     NOT NULL,
    MonthFullName         char(9)     NOT NULL,
    MonthYearShortName    char(8)     NOT NULL,
    MonthYearFullName     char(14)    NOT NULL,
    DayOfMonth            int         NOT NULL,
    DayOfYear             int         NOT NULL,
    WeekOfYear            int         NOT NULL,
    WeekOfYearKey         int         NOT NULL,
    WeekDay               int         NOT NULL,
    WeekDayName           char(9)     NOT NULL,
    IsWorkDay             bit         NOT NULL,
    WorkDayDescription    char(7)     NOT NULL,
    YTDStartDate          date        NULL,
    CONSTRAINT PK_Date PRIMARY KEY CLUSTERED (Date_SK)
)
go



