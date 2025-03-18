{% macro learn_variables() %}

    {% set your_name_jinja = "Filip" %}
    {{ log("Hello " ~ your_name_jinja, info = true) }}

    {{ log("Hello dbt user " ~ var("user_name", "NO USERNAME IS SET!!") ~ "!", info = true) }}
{% endmacro %}