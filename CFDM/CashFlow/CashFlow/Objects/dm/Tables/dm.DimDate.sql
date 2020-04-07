/* 
 * TABLE: dm.DimDate 
 */

CREATE TABLE dm.DimDate(
    Date_SK               int         IDENTITY(1,1),
    DateKey               int         NOT NULL,
    DateFull              date        NOT NULL,
    DateFullName          char(11)    NOT NULL,
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
    YTDStartDate          date        NOT NULL,
    Audit_Insert_Dt       datetime    CONSTRAINT [DF__DimValuat__Audit__59063A47] DEFAULT (getdate()) NULL,
    Audit_Update_Dt       datetime    CONSTRAINT [DF__DimValuat__Audit__59FA5E80] DEFAULT (getdate()) NULL,
    Ins_Proc_ID           int         NULL,
    Upd_Proc_ID           int         NULL,
    Is_Deleted            bit         NULL,
    Is_Active             bit         NULL,
    CONSTRAINT PK_DimDate PRIMARY KEY CLUSTERED (Date_SK)
)
go




