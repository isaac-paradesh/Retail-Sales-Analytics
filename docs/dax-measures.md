# DAX Measures

## Total Sales

```DAX
Total Sales =
SUM('Sales Data'[Sales])
```

## Total Orders

```DAX
Total Orders =
DISTINCTCOUNT('Sales Data'[Order ID])
```

## Total Customers

```DAX
Total Customers =
DISTINCTCOUNT('Sales Data'[Customer ID])
```

## Total Products

```DAX
Total Products =
DISTINCTCOUNT('Sales Data'[Product ID])
```

## Average Order Value

```DAX
Average Order Value =
DIVIDE(
    [Total Sales],
    [Total Orders]
)
```

## Sales per Customer

```DAX
Sales per Customer =
DIVIDE(
    [Total Sales],
    [Total Customers]
)
```

## Customer Rank

```DAX
Customer Rank =
RANKX(
    ALLSELECTED('Sales Data'[Customer Name]),
    [Total Sales],
    ,
    DESC,
    DENSE
)
```

## Year-over-Year Sales Growth

```DAX
YoY Sales Growth =
VAR CurrentSales =
    [Total Sales]

VAR PreviousSales =
    CALCULATE(
        [Total Sales],
        DATEADD('Date'[Date], -1, YEAR)
    )

RETURN
    DIVIDE(
        CurrentSales - PreviousSales,
        PreviousSales
    )
```
