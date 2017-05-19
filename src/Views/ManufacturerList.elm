module Views.ManufacturerList exposing (manufacturerList)

import Html exposing (Html, div, h5, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import Models exposing (Model)


manufacturerList : Model -> Html Msg
manufacturerList model =
  div [ class "row" ] [
    div [ class "col-12" ] [
      h5 [] [ text "Manufacturers" ]
    ]
  ]
