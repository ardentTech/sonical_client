module Views.ManufacturerList exposing (manufacturerList)

import Html exposing (Html, div, h5, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class)

import Messages exposing (Msg)
import Models exposing (Manufacturer, Model)


manufacturerList : Model -> Html Msg
manufacturerList model =
  div [ class "row" ] [
    div [ class "col-12" ] [
      h5 [] [ text "Manufacturers" ],
      table [] [
        thead [] [
          tr [] [ th [] [ text "Name" ], th [] [ text "Website" ]]
        ],
        tbody [] (List.map (\m -> toRow m) model.manufacturers)
      ]
    ]
  ]


-- PRIVATE


toRow : Manufacturer -> Html Msg
toRow manufacturer =
  let
    website = case manufacturer.website of
      Nothing -> "-"
      Just w -> w
  in
    tr [] [ td [] [ text manufacturer.name ], td [] [ text website ]]
