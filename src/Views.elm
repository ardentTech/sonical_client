module Views exposing (view)

import Html exposing (Html, div, table, tbody, td, text, thead, th, tr)
import Html.Attributes exposing (id)
import List exposing (map)

import Messages exposing (Msg)
import Models exposing (Driver, Model)


view : Model -> Html Msg
view model = 
  div [ id "drivers" ] [
    table [] [
      thead [] [ tableHeaderRow ],
      tbody [] (map tableBodyRow model.drivers)
    ]
  ]


-- PRIVATE

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
    td [] [ text <| (\v -> v ++ "Ω") <| toString <| justNum <| driver.nominal_impedance ]
  ]


tableHeaderRow : Html Msg
tableHeaderRow =
  tr [] [
    th [] [ text "ID" ],
    th [] [ text "Manufacturer" ],
    th [] [ text "Model" ],
    th [] [ text "Z" ]
  ]
