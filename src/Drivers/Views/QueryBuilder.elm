module Drivers.Views.QueryBuilder exposing (queryBuilder)

import Html exposing (
  Html, button, div, h5, table, tbody, td, text, textarea, th, thead, tr)
import Html.Attributes exposing (class, id, placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)

import Messages exposing (Msg (..))
import Models exposing (Model)


queryBuilder : Model -> Html Msg
queryBuilder model =
  let
    helpText = "Help " ++ (if model.driversQueryBuilderHelp then " [-]" else "[+]")
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
            ] [ text helpText ]
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
      help model.driversQueryBuilderHelp
    ]


-- PRIVATE


type alias QueryBuilderOption = {
  key : String,
  operators : String,
  dataType : String
}


float : String
float = "Float"


integer : String
integer = "Integer"


string : String
string = "String"


numericalOperators : String
numericalOperators = String.join ", " ["=", "__gt=", "__gte=", "__lt=", "__lte"]


stringOperators : String
stringOperators = String.join ", " ["=", "__contains=", "__icontains"]


optionsLeft : List QueryBuilderOption
optionsLeft =
  [
    QueryBuilderOption "bl_product" numericalOperators float,
    QueryBuilderOption "compliance_equivalent_volume" numericalOperators float,
    QueryBuilderOption "cone_surface_area" numericalOperators float,
    QueryBuilderOption "dc_resistance" numericalOperators float,
    QueryBuilderOption "diaphragm_mass_including_airload" numericalOperators float,
    QueryBuilderOption "electromagnetic_q" numericalOperators float,
    QueryBuilderOption "max_linear_excursion" numericalOperators float,
    QueryBuilderOption "max_power" numericalOperators integer,
    QueryBuilderOption "mechanical_compliance_of_suspension" numericalOperators float]


optionsRight : List QueryBuilderOption
optionsRight =
  [
    QueryBuilderOption "mechanical_q" numericalOperators float,
    QueryBuilderOption "model" stringOperators string,
    QueryBuilderOption "nominal_diameter" numericalOperators float,
    QueryBuilderOption "nominal_impedance" numericalOperators integer,
    QueryBuilderOption "resonant_frequency" numericalOperators float,
    QueryBuilderOption "rms_power" numericalOperators integer,
    QueryBuilderOption "sensitivity" numericalOperators float,
    QueryBuilderOption "voice_coil_diameter" numericalOperators float,
    QueryBuilderOption "voice_coil_inductance" numericalOperators float]


help : Bool -> Html Msg
help show =
  let
    visibility = if show then "block" else "none"
  in
    div [ class "row", style [("display", visibility)]]
      (List.map optionsTable [optionsLeft, optionsRight])


optionsTable : List QueryBuilderOption -> Html Msg
optionsTable options =
  let
    toTextCell = \t -> td [] [ text t ]
    toRow = \qbo -> tr [] (
      List.map (\q -> toTextCell q) [qbo.key, qbo.operators, qbo.dataType])
  in
    div [ class "col-6" ] [
      table [ class "table table-sm table-striped" ] [
        thead [] [ tr [] (List.map (\v -> th [] [ text v ]) ["Name", "Comparison Operators", "Type"])],
        tbody [] (List.map (\o -> toRow o) options)
      ]
    ]
