module Views.App exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href, id, attribute, type_)
import Html.Events exposing (onClick)

import Drivers.Views.DriverDetail exposing (driverDetail)
import Drivers.Views.DriverList exposing (driverList)
import Manufacturing.Views.ManufacturerList exposing (manufacturerList)
import Messages exposing (Msg (ErrorDismissed, NewUrl))
import Models exposing (Model)
import Router exposing (Route (DriverDetail, DriverList, ManufacturerList))
import Views.Alert exposing (alert)


view : Model -> Html Msg
view model =
  div [] [navbar, (container model (routeToView model.currentRoute model))]


-- PRIVATE


container : Model -> Html Msg -> Html Msg
container model subView =
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


navbar : Html Msg
navbar =
  nav [ class "navbar navbar-toggleable navbar-inverse bg-inverse fixed-top" ] [
    a [ class "navbar-brand", onClick (NewUrl "/") ] [ text "Sonical" ],
    div [] [
      ul [ class "navbar-nav mr-auto" ] [
        li [ class "nav-item" ] [
          a [ class "nav-link", onClick (NewUrl "/manufacturers" ) ] [ text "Manufacturers" ]
        ]   
      ]   
    ]
  ]

routeToView : Maybe Route -> Model -> Html Msg
routeToView route model =
  case route of
    Just (DriverDetail i) -> driverDetail model
    Just (DriverList _) -> driverList model
    Just ManufacturerList ->
      Html.map Messages.ManufacturingMsg <| manufacturerList model
    Nothing -> div [] [ h3 [] [ text "Invalid URL" ]]
