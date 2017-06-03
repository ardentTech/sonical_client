module Main exposing (main)

import Navigation exposing (Location, programWithFlags)
import Table
import UrlParser exposing (parsePath)

import Commands exposing (cmdFromRoute)
import Drivers.QueryParams exposing (unpack)
import Messages exposing (Msg(..))
import Models exposing (Model)
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


defaultModel : Model
defaultModel = {
  apiUrl = "",
  currentRoute = Nothing,
  driver = Nothing,
  driverGroups = [],
  drivers = [],
  driversCount = 0,
  driversNextPage = Nothing,
  driversPreviousPage = Nothing,
  driversQuery = "",
  driversQueryBuilderHelp = False,
  error = "",
  manufacturers = [],
  tableState = (Table.initialSort "Manufacturer")}


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
  let
    -- @todo initialModel
    currentRoute = parsePath route location
    model = { defaultModel |
      currentRoute = currentRoute,
      apiUrl = flags.apiUrl,
      driversQuery =
        case currentRoute of
          Just (DriverList (Just q)) -> unpack q
          _ -> ""
    }
  in
    (model, cmdFromRoute model)
