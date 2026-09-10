# Tembo Hotel Operational Analysis
### Project Scenario

I was hypothetically hired as a Junior Data Analyst at Tembo Hotel & Suites - a mid-range business hotel in Nairobi. The hotel has been running since 2023 and keeping records in a spreadsheet. That spreadsheet was in a mess.

The manager - the Hotel Director - handed me a raw CSV export of all booking data and said:

*"We need to understand how the hotel is performing. The data team before you kept everything in Excel and it is full of errors.
I need you to clean this data, load it into our new database, analyse it, and present your findings to the management team on Friday.
I want to know: which rooms make us the most money, which months are busiest, how our staff are performing, and whether our guests are happy.
Make it look professional - use Power BI for the visuals."*

#### The Data - tembo_hotel_dirty.csv

The CSV file had ~285 rows of hotel booking records. This was real-world style data - it had many problems that was found and fix before any analysis begun.

### Important Stages
*__Step 1__*
- The csv file was imported into a __postgreSQL__ database
- In the postgreSQL database - The data was cleaned to ensure consistent values in each of the columns
- After cleaning I did some analysis in postgreSQL and created __views__ which can be used by the powerbi analyst to load the data

*__Step 2__*
- Loaded the data in PoweBi by connecting it to the PostgreSQL database
- Connected the PowerBi with the database and loadd the views which could then be used for analysis and draw insights

#### Analysis Queries 
Business questions:
1.	Revenue analysis: Total revenue by month, by room type, by payment method
2.	Occupancy: Which room types are booked most? Average nights stayed per room type
3.	Guest insights: Top 10 cities guests come from. Average rating per room type
4.	Staff performance: Which staff handled the most bookings? Which department generates most revenue?
5.	Trends: Revenue growth month over month (window function). Busiest vs quietest months
6.	Cancellations: Cancellation rate per room type. Revenue lost from cancellations and no-shows

## Tembo Dashboard
<img width="1366" height="768" alt="Screenshot (59)" src="https://github.com/user-attachments/assets/fecf16a8-bb48-4802-bf8b-3a57f6743ce7" />

## Recommendations
<img width="1366" height="768" alt="Screenshot (58)" src="https://github.com/user-attachments/assets/18d6eaa5-b981-4d38-ba91-9b0b92084a43" />
