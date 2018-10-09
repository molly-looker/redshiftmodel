view: pdt {
  derived_table: {
      sql: SELECT 'woohoo 😘' as kisses, id, sum(id) as sum
      from orders
      group by 1, 2;;
    sql_trigger_value: SELECT MINUTE(CURTIME()) ;;
  }

dimension: emoji {
  type: string
  sql:${TABLE}.kisses ;;
}

dimension: id {
  type: number
  sql:${TABLE}.id ;;
}

measure: count {
  type: count
  drill_fields: [id, emoji]
  }
}
