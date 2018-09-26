view: orders_pdt {
  derived_table: {
    sql: select * from public.orders ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;




    html: {% if value == "" %}
        <div style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</div>
        {% else %}
        {{ rendered_value }}
        {% endif %} ;;
  }

  parameter: statusparam {
    type: string
    suggest_dimension:  status
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.first_name, users.id, order_items.count]
  }
}
