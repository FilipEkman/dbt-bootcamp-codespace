with
r as (
    select
        *
    from
        {{ ref('fct_reviews') }}
),
l as (
    select
        *
    from
        {{ ref('dim_listings_cleansed') }}
)

select 
    r.review_date,
    l.created_at

from r
left join l on (r.listing_id = l.listing_id)

where r.review_date < l.created_at

limit 1