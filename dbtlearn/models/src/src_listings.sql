-- AIRBNB.RAW.RAW_LISTINGS change column names
with raw_listings as(
    select * from AIRBNB.RAW.RAW_LISTINGS
)
select
    id as lsting_id,
    name as listing_name,
    listing_url,
    room_type,
    minimum_nights,
    host_id,
    price as price_str,
    created_at,
    updated_at
from
    raw_listings