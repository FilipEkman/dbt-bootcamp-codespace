{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}
with src_reviews as(
    select * from {{ ref('src_reviews') }}
)
select
{{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id,
 * from src_reviews
where review_text is not null

{% if is_incremental() %}
    {% if var("start_date", false) and var("end_date", false) %}
        {{ log('Loading ' ~ this ~ ' incementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info = true) }}
        and review_date >= '{{ var("start_date") }}'
        and review_date < '{{ var("end_date") }}'
    {% else %}
        and review_date > (select max(review_date) from {{ this }})
        {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info = true) }}
    {% endif %}
{% endif %}