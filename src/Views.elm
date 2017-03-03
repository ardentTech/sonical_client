module Views exposing (view)

import Html exposing (Html, div, table, tbody, td, text, thead, th, tr)
import Html.Attributes exposing (class, id)
import List exposing (map)

import Messages exposing (Msg)
import Models exposing (Driver, FrequencyResponse, Model)


view : Model -> Html Msg
view model = 
  div [ id "drivers" ] [
    table [ class "table table-responsive table-sm table-striped" ] [
      thead [] [ tableHeaderRow ],
      tbody [] (map tableBodyRow model.drivers)
    ]
  ]


-- PRIVATE

frequencyResponseCell : FrequencyResponse -> String
frequencyResponseCell fr =
  let
    lower = toString <| justNum <| fr.lower
    upper = toString <| justNum <| fr.upper
  in
    lower ++ "-" ++ upper ++ "Hz"


-- @todo move to lib
justNum : Maybe number -> number
justNum n =
  case n of
    Nothing -> 0
    Just m -> m


tableBodyRow : Driver -> Html Msg
tableBodyRow driver =
  tr [] [ 
    td [] [ text <| toString <| driver.id ],
    td [] [ text <| driver.manufacturer.name ],
    td [] [ text <| driver.model ],
    td [] [ text <| (\v -> v ++ "Ω") <| toString <| justNum <| driver.nominal_impedance ],
    td [] [ text <| (\v -> v ++ "Hz") <| toString <| justNum <| driver.resonant_frequency ],
    td [] [ text <| (\v -> v ++ " dB 1W/1m") <| toString <| justNum <| driver.sensitivity ],
    td [] [ text <| frequencyResponseCell <| driver.frequency_response ]
  ]


tableHeaderRow : Html Msg
tableHeaderRow =
  tr [] [
    th [] [ text "ID" ],
    th [] [ text "Manufacturer" ],
    th [] [ text "Model" ],
    th [] [ text "Z" ],
    th [] [ text "Fs" ],
    th [] [ text "Sensitivity" ],
    th [] [ text "Fr" ]
  ]
