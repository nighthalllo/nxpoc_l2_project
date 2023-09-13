view: lgcns_golla_nxuser2 {
  sql_table_name: `NXPOC_L2.LGCNS_GOLLA_NXUSER2` ;;

  dimension_group: creation {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.creation_date ;;
  }
  dimension: is_main_account {
    type: string
    sql: ${TABLE}.is_main_account ;;
  }
  dimension_group: last_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.last_update_date ;;
  }
  dimension: new_or_return_user {
    type: string
    sql: ${TABLE}.new_or_return_user ;;
  }
  dimension: nexonsn {
    type: number
    sql: ${TABLE}.nexonsn ;;
  }
  dimension: same_response_ratio {
    type: number
    sql: ${TABLE}.same_response_ratio ;;
  }
  dimension: suvey_group {
    type: number
    sql: ${TABLE}.suvey_group ;;
  }
  dimension: user_segmentation {
    type: string
    sql: ${TABLE}.user_segmentation ;;
  }
  parameter: dynamic_dimension_selection {
    type: unquoted
    default_value: "all"
    allowed_value: {
      value: "all"
      label: "전체"
    }
    allowed_value: {
      value: "segmentation"
      label: "유저그룹"}
    allowed_value: {
      value: "group"
      label: "설문그룹"}
    allowed_value: {
      value: "return"
      label: "신규/복귀"}
  }
  dimension: dynamic_dimension {
    label_from_parameter: dynamic_dimension_selection
    type: string
    sql:
    {% if dynamic_dimension_selection._parameter_value == 'segmentation' %}
    ${user_segmentation}
    {% elsif dynamic_dimension_selection._parameter_value == 'group' %}
    ${suvey_group}
    {% elsif dynamic_dimension_selection._parameter_value == 'return' %}
    ${new_or_return_user}
    {% else %}
    null
    {% endif %} ;;
  }
  measure: count {
    type: count
  }
}
