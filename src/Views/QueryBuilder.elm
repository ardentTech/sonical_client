module Views.QueryBuilder exposing (queryBuilder)

import Html exposing (
  Html, button, div, h5, table, tbody, td, text, textarea, th, thead, tr)
import Html.Attributes exposing (class, id, placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)

import Messages exposing (Msg (..))
import Models exposing (Model)


queryBuilder : Model -> Html Msg
queryBuilder model =
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
          ] [ text "Toggle Help" ]
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


-- @todo more efficient way to build operator lists
-- @todo more efficient way to assign operator lists to row configs
-- @todo new type for row config
queryBuilderHelp : Bool -> Html Msg
queryBuilderHelp show =
  let
    contains = "__contains" ++ eq
    eq = "="
    float = "Float"
    gt = "__gt" ++ eq
    gte = "__gte" ++ eq
    icontains = "__icontains" ++ eq
    integer = "Integer"
    lt = "__lt" ++ eq
    lte = "__lte" ++ eq
    numerical_operators = String.join ", " [eq, gt, gte, lt, lte]
    string = "String"
    string_operators = String.join ", " [eq, contains, icontains]
    rows = [
      ["bl_product", numerical_operators, float],
      ["compliance_equivalent_volume", numerical_operators, float],
      ["cone_surface_area", numerical_operators, float],
      ["dc_resistance", numerical_operators, float],
      ["diaphragm_mass_including_airload", numerical_operators, float],
      ["electromagnetic_q", numerical_operators, float],
      ["max_linear_excursion", numerical_operators, float],
      ["max_power", numerical_operators, integer],
      ["mechanical_compliance_of_suspension", numerical_operators, float],
      ["mechanical_q", numerical_operators, float],
      ["model", string_operators, string],
      ["nominal_diameter", numerical_operators, float],
      ["nominal_impedance", numerical_operators, integer],
      ["resonant_frequency", numerical_operators, float],
      ["rms_power", numerical_operators, integer],
      ["sensitivity", numerical_operators, float],
      ["voice_coil_diameter", numerical_operators, float],
      ["voice_coil_inductance", numerical_operators, float]
    ]
    visibility = if show then "block" else "none"
  in
    div [ class "row", style [("display", visibility)] ] [
      div [ class "col-12" ] [
        table [ class "table table-sm table-striped" ] [
          thead [] [ tr [] (List.map (\v -> th [] [ text v ]) ["Name", "Comparison Operators", "Type"])],
          tbody [] (List.map (\r -> tr [] (List.map (\rd -> td [] [ text rd ]) r)) rows)
        ]
      ]
    ]
