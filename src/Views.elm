module Views exposing (view)

import Html exposing (Html, div, table, tbody, td, text, thead, th, tr)
import Html.Attributes exposing (id)
import List exposing (map)

import Messages exposing (Msg)
import Models exposing (Driver, Model)


-- View.elm

view : Model -> Html Msg
view model = 
  div [ id "drivers" ] [
    table [] [
      thead [] [ tableHeaderRow ],
      tbody [] (map tableBodyRow model.drivers)
    ]
  ]

tableBodyRow : Driver -> Html Msg
tableBodyRow driver =
  tr [] [ 
    td [] [ text <| driver.model ]
  ]


tableHeaderRow : Html Msg
tableHeaderRow =
  tr [] [
    th [] [ text "Model" ]
  ]
