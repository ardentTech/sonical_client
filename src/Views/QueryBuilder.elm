module Views.QueryBuilder exposing (queryBuilder)

import Html exposing (
  Html, button, div, h5, table, tbody, td, text, textarea, th, thead, tr)
import Html.Attributes exposing (class, id, placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)

import Messages exposing (Msg (..))
import Models exposing (Model)


queryBuilder : Model -> Html Msg
queryBuilder model =
  let
    helpControlText = "Help " ++ (if model.driversQueryBuilderHelp then " [-]" else "[+]")
  in
    div [ id "query-builder" ] [
      h5 [] [ text "Driver Query Builder" ],
      Html.form [ class "clearfix", onSubmit QueryBuilderSubmitted ] [
        div [ class "form-group" ] [
          textarea [
            class "form-control",
            onInput QueryBuilderUpdated,
            placeholder "manufacturer=3&dc_resistance__gte=4",
            value model.driversQuery ] [ ]
        ],
        div [ class "float-left" ] [
          button [
              class "btn btn-md btn-link",
              onClick QueryBuilderHelpClicked,
              type_ "button"
            ] [ text helpControlText ]
        ],
        div [ class "float-right" ] [
          button [
              class "btn btn-md btn-secondary",
              onClick QueryBuilderCleared,
              type_ "button"
            ] [ text "Clear" ],
          button [
            class "btn btn-md btn-primary", type_ "submit" ] [ text "Submit" ]
        ]
      ],
      queryBuilderHelp model.driversQueryBuilderHelp
    ]


-- PRIVATE


type alias QueryBuilderOption = {
  key : String,
  operators : String,
  dataType : String
}


getQueryBuilderOptions : List QueryBuilderOption
getQueryBuilderOptions =
  let
    float = "Float"
    integer = "Integer"
    numerical_operators = String.join ", " ["=", "__gt=", "__gte=", "__lt=", "__lte"]
    string = "String"
    string_operators = String.join ", " ["=", "__contains=", "__icontains"]
  in
    -- 'QueryBuilderOption' repetition sucks...
    [
      QueryBuilderOption "bl_product" numerical_operators float,
      QueryBuilderOption "compliance_equivalent_volume" numerical_operators float,
      QueryBuilderOption "cone_surface_area" numerical_operators float,
      QueryBuilderOption "dc_resistance" numerical_operators float,
      QueryBuilderOption "diaphragm_mass_including_airload" numerical_operators float,
      QueryBuilderOption "electromagnetic_q" numerical_operators float,
      QueryBuilderOption "max_linear_excursion" numerical_operators float,
      QueryBuilderOption "max_power" numerical_operators integer,
      QueryBuilderOption "mechanical_compliance_of_suspension" numerical_operators float,
      QueryBuilderOption "mechanical_q" numerical_operators float,
      QueryBuilderOption "model" string_operators string,
      QueryBuilderOption "nominal_diameter" numerical_operators float,
      QueryBuilderOption "nominal_impedance" numerical_operators integer,
      QueryBuilderOption "resonant_frequency" numerical_operators float,
      QueryBuilderOption "rms_power" numerical_operators integer,
      QueryBuilderOption "sensitivity" numerical_operators float,
      QueryBuilderOption "voice_coil_diameter" numerical_operators float,
      QueryBuilderOption "voice_coil_inductance" numerical_operators float
    ]


queryBuilderHelp : Bool -> Html Msg
queryBuilderHelp show =
  let
    options = getQueryBuilderOptions
    toTextCell = \t -> td [] [ text t ]
    toRow = \qbo -> tr [] (
      List.map (\q -> toTextCell q) [qbo.key, qbo.operators, qbo.dataType])
    visibility = if show then "block" else "none"
  in
    div [ class "row", style [("display", visibility)] ] [
      div [ class "col-12" ] [
        table [ class "table table-sm table-striped" ] [
          thead [] [ tr [] (List.map (\v -> th [] [ text v ]) ["Name", "Comparison Operators", "Type"])],
          tbody [] (List.map (\o -> toRow o) options)
        ]
      ]
    ]
