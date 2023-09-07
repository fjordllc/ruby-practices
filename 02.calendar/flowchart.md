```mermaid
sequenceDiagram
    main->>calendar: year, month(nilを許容する)
    calendar->>calendar: initialize year, month(nilは現在の値を入れる。)
    calendar->>main: calendarを返却する。
```
