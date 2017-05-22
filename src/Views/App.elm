module Views.App exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href, id, attribute, type_)
import Html.Events exposing (onClick)

import Messages exposing (Msg (ErrorDismissed, NewUrl))
import Models exposing (Model)
import Router exposing (Route (DriverDetail, DriverList, ManufacturerList))
import Views.Alert exposing (alert)
import Views.DriverDetail exposing (driverDetail)
import Views.DriverList exposing (driverList)
import Views.ManufacturerList exposing (manufacturerList)


view : Model -> Html Msg
view model =
  let
    subView = routeToView model.currentRoute model
  in
    div [] [
      nav [ class "navbar navbar-toggleable navbar-inverse bg-inverse fixed-top" ] [
        a [ class "navbar-brand", onClick (NewUrl "/") ] [ text "Sonical" ],
        div [] [
          ul [ class "navbar-nav mr-auto" ] [
            li [ class "nav-item" ] [
              a [ class "nav-link", onClick (NewUrl "/manufacturers" ) ] [ text "Manufacturers" ]
            ]   
          ]   
        ]
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

routeToView : Maybe Route -> Model -> Html Msg
routeToView route model =
  case route of
    Just (DriverDetail i) -> driverDetail model
    Just (DriverList Nothing) -> driverList model
    Just (DriverList (Just limit)) -> driverList model
    Just ManufacturerList -> manufacturerList model
    Nothing -> div [] [ h3 [] [ text "Invalid URL" ]]
