# Partitioning Performance Report

## Objective
Improve query performance on the bookings table by implementing range partitioning on the start_date column.

---

## Steps Taken
1. Renamed original bookings table to `bookings_old` to preserve data.
2. Created a new `bookings` table partitioned by RANGE (start_date).
3. Defined partitions per year:
   - bookings_2022
   - bookings_2023
   - bookings_2024
   - bookings_future
4. Inserted existing data back into the partitioned table.

---

## Performance Testing

### Test Query
```sql
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';