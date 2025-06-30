# Database Indexing 


By identifying high-usage columns and creating indexes on them, we aim to improve query performance, especially for large datasets.

---

## Indexing Goals

- Speed up **WHERE**, **JOIN**, and **ORDER BY** queries
- Reduce full table scans
- Support frequent query patterns

---

##  High-Usage Columns Identified

### Users Table
| Column    | Usage                          | Index Needed?                     |
|-----------|-------------------------------|-----------------------------------|
| user_id   | Primary key, joins            | Already indexed (PK)              |
| email     | Login lookups (WHERE)         | Already indexed (UNIQUE constraint) |

**No new manual indexes required** for this table.

---

### Bookings Table
| Column       | Usage                                           | Index Reason                        |
|--------------|-------------------------------------------------|-------------------------------------|
| user_id      | WHERE, JOIN with Users                          | Accelerate user-based lookups       |
| property_id  | WHERE, JOIN with Properties                     | Accelerate property-based lookups   |
| start_date   | WHERE, ORDER BY for date-range searches         | Speed up date filtering             |

---

### Properties Table
| Column    | Usage                             | Index Reason                     |
|-----------|-----------------------------------|----------------------------------|
| host_id   | JOIN with Users                   | Accelerate host property lookups |
| price     | WHERE, ORDER BY for price ranges | Speed up price-based filtering   |

---

##  SQL Index Creation Commands



```sql
-- Bookings table indexes
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);

-- Properties table indexes
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_price ON properties(price);


 
```sql
--- Example: Analyze query performance with the new index
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = 'some-uuid';

