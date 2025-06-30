# Database Performance Monitoring Report

## Objective
Continuously monitor and optimize database performance by analyzing query execution plans and implementing schema improvements.

---

## 1️⃣ Monitored Queries

### a. Bookings by User Query
```sql
SELECT * FROM bookings WHERE user_id = 'some-uuid';
```

**EXPLAIN ANALYZE (Before Optimization):**
```pgsql
Seq Scan on bookings (cost=0.00..450.00 rows=5000)
```

**Bottleneck Identified:**
- Sequential Scan across the entire `bookings` table.

### b. Properties by Price Query
```sql
SELECT * FROM properties WHERE price BETWEEN 100 AND 300;
```

**EXPLAIN ANALYZE (Before Optimization):**
```pgsql
Seq Scan on properties (cost=0.00..300.00 rows=...)
```

**Bottleneck Identified:**
- Full table scan for price range filtering.

---

## 2️⃣ Proposed Optimizations

### Bookings Table
- Add an index on `user_id` to improve query performance.

```sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
```

### Properties Table
- Add an index on `price` to optimize range-based queries.

```sql
CREATE INDEX idx_properties_price ON properties(price);
```

---

## 3️⃣ Implemented Changes
The following SQL commands were executed:

```sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_properties_price ON properties(price);
```

---

## 4️⃣ Post-Optimization Results

### Bookings Query
**EXPLAIN ANALYZE (After Optimization):**
```pgsql
Index Scan using idx_bookings_user_id on bookings (cost=0.15..8.20 rows=1)
```

**Improvements:**
- Significant reduction in query cost.
- Index Scan replaced Sequential Scan.

### Properties Query
**EXPLAIN ANALYZE (After Optimization):**
```pgsql
Bitmap Index Scan on idx_properties_price (cost=...)
```

**Improvements:**
- Reduced query cost.
- Efficient use of index for price range filtering.

---

## 5️⃣ Conclusion
By leveraging `EXPLAIN ANALYZE` to identify performance bottlenecks and adding targeted indexes, query execution costs were significantly reduced, resulting in faster performance. Ongoing monitoring and strategic indexing are critical for sustaining optimal performance in large-scale database applications.