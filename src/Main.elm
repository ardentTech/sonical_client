module Main exposing (main)

import Navigation exposing (Location, programWithFlags)
import UrlParser exposing (parsePath)

import Commands exposing (routeToCmd)
import Drivers.QueryParams exposing (unpack)
import Messages exposing (Msg(..))
import Models exposing (Model, defaultModel)
import Router exposing (Route (DriverList), route)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import Views.App exposing (view)


type alias Flags = { apiUrl: String }


main : Program Flags Model Msg
main = programWithFlags UrlChange {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions }


-- PRIVATE


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
  let
    currentRoute = parsePath route location
    baseModel = { defaultModel | apiUrl = flags.apiUrl, currentRoute = currentRoute }
    model = case currentRoute of
      Just (DriverList (Just q)) -> { baseModel | driversQuery = (unpack q) }
      _ ->  baseModel
    cmd = routeToCmd model
  in
    (model, cmd)
