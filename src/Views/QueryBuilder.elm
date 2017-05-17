module Views.QueryBuilder exposing (queryBuilder)

import Html exposing (Html, button, div, h5, table, tbody, td, text, textarea, th, thead, tr)
import Html.Attributes exposing (class, id, placeholder, type_, value)
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
    queryBuilderHelp
  ]


-- PRIVATE


queryBuilderHelp : Html Msg
queryBuilderHelp =
  let
    float = "Float"
    integer = "Integer"
    string = "String"
    rows = [
      ["bl_product", float],
      ["compliance_equivalent_volume", float],
      ["cone_surface_area", float],
      ["dc_resistance", float],
      ["diaphragm_mass_including_airload", float],
      ["electromagnetic_q", float],
      ["max_linear_excursion", float],
      ["max_power", integer],
      ["mechanical_compliance_of_suspension", float],
      ["mechanical_q", float],
      ["model", string],
      ["nominal_diameter", float],
      ["nominal_impedance", integer],
      ["resonant_frequency", float],
      ["rms_power", integer],
      ["sensitivity", float],
      ["voice_coil_diameter", float],
      ["voice_coil_inductance", float]
    ]
  in
    div [ class "row" ] [
      div [ class "col-12" ] [
        table [ class "table table-sm table-striped" ] [
          thead [] [ tr [] [ th [] [ text "Name" ], th [] [ text "Type" ]] ],
          tbody [] (List.map (\r -> tr [] (List.map (\rd -> td [] [ text rd ]) r)) rows)
        ]
      ]
    ]
