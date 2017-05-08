module Views.App exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href, id, type_)
import Html.Events exposing (onClick)

import Messages exposing (Msg (ErrorDismissed, NewUrl))
import Models exposing (Model)
import Router exposing (Route (DriverDetail, DriverList))
import Views.NotFound exposing (notFound)
import Views.DriverDetail exposing (driverDetail)
import Views.DriverList exposing (driverList)


view : Model -> Html Msg
view model =
  let
    copyright = "© 2017 Ardent TechniCreative"
    subView = case model.currentRoute of
      Just DriverList -> driverList model
      Just (DriverDetail id) -> driverDetail model id
      Nothing -> notFound
  in
    div [] [
      nav [ class "navbar navbar-toggleable-md navbar-inverse bg-inverse fixed-top" ] [
        a [ class "navbar-brand", href "/", onClick (NewUrl "/") ] [ text "Sonical" ]
      ],
      div [ class "container" ] [
        div [ class "row" ] [
          div [ class "col-12" ] [ (alert model), subView ]
        ],
        hr [] [],
        footer [] [
          p [ class "float-right text-muted" ] [
            small [] [ text copyright ]
          ]   
        ]
      ]
    ]

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
