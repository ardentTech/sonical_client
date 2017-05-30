module Update exposing (update)

import Navigation exposing (newUrl)
import UrlParser exposing (parsePath)

import Commands exposing (..)
import Drivers.Update
import Manufacturing.Update
import Messages exposing (Msg (..))
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
        ( newModel, Cmd.map ManufacturingMsg cmd )
    NewUrl url ->
      ( model, newUrl url )
    UrlChange location ->
      let
        newRoute = parsePath route location
        newModel = { model | currentRoute = newRoute }
      in
        if (model.currentRoute == newRoute) then
          (model, Cmd.none)
        else
          (newModel, routeToCmd newModel )
