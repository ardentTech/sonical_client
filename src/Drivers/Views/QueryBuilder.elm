module Drivers.Views.QueryBuilder exposing (queryBuilder)

import Html exposing (
  Html, button, code, div, h5, h6, hr, p, table, tbody, td, text, textarea, th, thead, tr)
import Html.Attributes exposing (class, id, placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)

import Messages exposing (Msg (..))
import Models exposing (Model)


-- @todo would be awesome to allow clicks on table cells and dynamically fill in the text box
queryBuilder : Model -> Html Msg
queryBuilder model =
  let
    helpToggleText = "Help " ++ (if model.driversQueryBuilderHelp then " [-]" else "[+]")
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
            ] [ text helpToggleText ]
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


-- @todo add manufacturer and materials
options : List QueryBuilderOption
options =
  [
    QueryBuilderOption "bl_product" numericalOperators float,
    QueryBuilderOption "compliance_equivalent_volume" numericalOperators float,
    QueryBuilderOption "cone_surface_area" numericalOperators float,
    QueryBuilderOption "dc_resistance" numericalOperators float,
    QueryBuilderOption "diaphragm_mass_including_airload" numericalOperators float,
    QueryBuilderOption "electromagnetic_q" numericalOperators float,
    QueryBuilderOption "max_linear_excursion" numericalOperators float,
    QueryBuilderOption "max_power" numericalOperators integer,
    QueryBuilderOption "mechanical_compliance_of_suspension" numericalOperators float,
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
    visibility = if show then "flex" else "none"
  in
    div [ class "row", id "query-builder-help", style [("display", visibility)]] [
      optionsTable options, optionsHelp ]


optionsHelp : Html Msg
optionsHelp =
  div [ class "col-md-4" ] [
    h6 [] [ text "Help" ],
    p [] [ text """
      Query string statements use the format: <name><operator><type>. Create compound query 
      strings by separating statements with the '&' character. Manually inserting the leading      '?' is optional.
    """ ],
    h6 [] [ text "Examples" ],
    p [] [ text "Nominal diameter greater than 4\" and RMS power of exactly 50W:" ],
    code [] [ text "nominal_diameter__gt=4&rms_power=50" ],
    hr [] [],
    p [] [ text "Model contains case-insensitive word \"classic\":" ],
    code [] [ text "model__icontains=classic" ],
    hr [] [],
    p [] [ text "Mechanical Q greater than 2.0 and less that or equal to 3.1:" ],
    code [] [ text "mechanical_q__gt=2.0&mechanical_q__lte=3.1" ]
  ]


optionsTable : List QueryBuilderOption -> Html Msg
optionsTable options =
  let
    toTextCell = \t -> td [] [ text t ]
    toRow = \qbo -> tr [] (
      List.map (\q -> toTextCell q) [qbo.key, qbo.operators, qbo.dataType])
  in
    div [ class "col-md-8" ] [
      table [ class "table table-sm table-striped" ] [
        -- @todo inclue unit column
        thead [] [ tr [] (List.map (\v -> th [] [ text v ]) ["Name", "Operators", "Type"])],
        tbody [] (List.map (\o -> toRow o) options)
      ]
    ]
