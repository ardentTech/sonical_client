module Views.ManufacturerList exposing (manufacturerList)

import Html exposing (Html, a, div, h5, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class, href, target)

import Messages exposing (Msg)
import Models exposing (Manufacturer, Model)


manufacturerList : Model -> Html Msg
manufacturerList model =
  div [ class "row" ] [
    div [ class "col-12" ] [
      h5 [] [ text "Manufacturers" ],
      table [ class "table table-sm table-striped" ] [
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
    website = case (String.length manufacturer.website) of
      0 -> text ""
      _ -> a [ href manufacturer.website, target "_blank" ] [ text manufacturer.website ]
  in
    tr [] [ td [] [ text manufacturer.name ], td [] [ website ]]
