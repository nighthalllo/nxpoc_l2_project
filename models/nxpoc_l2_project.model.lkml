connection: "nxpoc_l2"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: nxpoc_l2_project_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: nxpoc_l2_project_default_datagroup

explore: lgcns_golla_nxuser {}

explore: lgcns_golla_nxuser2 {
  view_name: lgcns_golla_nxuser2
  label: "lgcns_golla_nxuser2"
  join: lgcns_golla_survey_unpivot {
    type: left_outer
    sql_on: ${lgcns_golla_nxuser2.nexonsn} = ${lgcns_golla_survey_unpivot.nexonsn} ;;
    relationship: many_to_one
  }
}
explore: lgcns_golla_survey_pivot {}

explore: lgcns_golla_survey_unpivot {
  join: lgcns_golla_surveyform {
    type: left_outer
    sql_on: ${lgcns_golla_survey_unpivot.question_id} = ${lgcns_golla_surveyform.question_id} ;;
    relationship: many_to_one
  }
}

explore: lgcns_golla_surveyform { }

explore: nxpoc_l2 {
  extends: [lgcns_golla_nxuser2]
  label: "nxpoc_l2"
}
