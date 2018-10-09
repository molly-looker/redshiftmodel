view: orders {
  sql_table_name: public.orders ;;

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


  dimension: full_TAT {
    description: "Time from final P&M submission to Design Sent"
    type: number
    sql: datediff(hour, ${users.created_time}, ${created_time})/24 ;;
    value_format: "0.00"
  }
  dimension: full_TAT_buckets {
    description: "Time buckets from final P&M submission to Design Sent"
    type: tier
    tiers: [0,5,10,15]
    style: classic
    sql: datediff(hour, ${users.created_time}, ${created_time})/24 ;;
    value_format: "0"
  }

  dimension: order_amount {
    type: number
    sql: ${TABLE}.order_amount ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.id, users.name, order_items.count]
  }
}
