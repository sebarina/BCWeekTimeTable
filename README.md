# BCWeekTimeTable - iOS周计划视图库

## 一、 CalendarView
- UI的配置： CalendarView的成员变量 appearance设置（CalendarViewAppearance）
- 事件的响应：选中dayView， 当前时间更新等事件，通过delegate回调<pre>calendarDelegate : CalendarViewDelegate?</pre>

## 二、 WeekTimeCollectionView
- UI的配置：  appearanceDelegate : WeekTimeAppearanceDelegate

- 事件的响应：  weekTimeDelegate : WeekTimeTableDelegate?

## 三、 WeekTimeTableView

UI配置：  weekTimeAppearanceDelegate : WeekTimeAppearanceDelegate?
<pre>init(frame: CGRect, appearance: CalendarViewAppearance = CalendarViewAppearance())</pre>

事件响应：  weekTimeDelegate : WeekTimeTableDelegate?
<pre>
    optional func weekTimeTableAddEvent(starTime: NSDate, endTime: NSDate) -> Void
    optional func weekTimeTableDidSelectEvent(event: AnyObject?) -> Void
    optional func weekTimeWeekTimeUpdated(starTime: NSDate) -> Void
</pre>

## 效果图
![weektimetable1](http://utility.uteacher.me/weektimetable1.png)![weektimetable2](http://utility.uteacher.me/weektimetable2.png)

