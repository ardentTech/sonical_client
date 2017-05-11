module Views.Alert exposing (alert)

import Html exposing (..)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onClick)

import Messages exposing (Msg (ErrorDismissed))
import Models exposing (Model)


alert : Model -> Html Msg
alert model =
  let
    markup = case String.length model.errorMessage > 0 of
      True ->  div [ class "alert alert-danger" ] [
          button [ class "close", onClick ErrorDismissed, type_ "button" ] [
            span [] [ text "×" ]],
          strong [] [ text "Error! " ],
          text model.errorMessage
        ]
      False -> text ""
  in
    markup
