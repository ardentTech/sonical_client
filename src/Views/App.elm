module Views.App exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href, id, type_)
import Html.Events exposing (onClick)

import Messages exposing (Msg (ErrorDismissed, NewUrl))
import Models exposing (Model)
import Router exposing (Route (DriverDetail, DriverList))
import Views.Alert exposing (alert)
import Views.NotFound exposing (notFound)
import Views.DriverDetail exposing (driverDetail)
import Views.DriverList exposing (driverList)


view : Model -> Html Msg
view model =
  let
    subView = case model.currentRoute of
      Just route -> routeToView route model
      Nothing -> notFound  -- @todo should be "invalid URL" something...
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
            small [] [ text "© 2017 Ardent TechniCreative" ]
          ]   
        ]
      ]
    ]


-- PRIVATE

routeToView : Route -> Model -> Html Msg
routeToView route model =
  case route of
    DriverList -> driverList model
    DriverDetail id -> driverDetail model id
