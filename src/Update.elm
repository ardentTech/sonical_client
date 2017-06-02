module Update exposing (update)

import Navigation exposing (newUrl)
import UrlParser exposing (parsePath)

import Commands exposing (routeToCmd)
import Drivers.Update
import Manufacturing.Update
import Messages exposing (..)
import Models exposing (Model)
import Router exposing (route)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ErrorDismissed ->
      ({ model | error = "" }, Cmd.none )
    DriversMsg subMsg ->
      let
        ( newModel, cmd ) = Drivers.Update.update subMsg model
      in
        ( newModel, Cmd.map DriversMsg cmd )
    ManufacturingMsg subMsg ->
      let
        ( newModel, cmd ) = Manufacturing.Update.update subMsg model
      in
        ( newModel, (Cmd.map childTranslator cmd))
    NewUrl url ->
      ( model, newUrl url )
    UrlChange location ->
      let
        newRoute = parsePath route location
      in
        if (model.currentRoute == newRoute) then (model, Cmd.none)
        else
          let
            newModel = { model | currentRoute = newRoute }
          in
            (newModel, routeToCmd newModel )
