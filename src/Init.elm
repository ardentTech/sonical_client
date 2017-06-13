module Init exposing (Flags, init)

import Navigation exposing (Location)
import Table exposing (initialSort)
import UrlParser exposing (parsePath)

import Commands exposing (cmdFromRoute)
import Messages exposing (Msg)
import Models exposing (Model)
import QueryParams exposing (unpack)
import Router exposing (Route (DriverList), route)


type alias Flags = { apiUrl: String }


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
  let
    model = initialModel flags location
  in
    (model, cmdFromRoute model)


-- PRIVATE


initialModel : Flags -> Location -> Model
initialModel flags location = 
  let
    apiUrl = flags.apiUrl
    currentRoute = parsePath route location
    driversQuery =
      case currentRoute of
        Just (DriverList (Just q)) -> unpack q
        _ -> ""
  in
    {
      apiUrl = apiUrl,
      currentRoute = currentRoute,
      driver = Nothing,
      driverGroups = [],
      drivers = [],
      driversCount = 0,
      driversNextOffset = Nothing,
      driversPreviousOffset = Nothing,
      driversQuery = driversQuery,
      driversQueryBuilderHelp = False,
      error = "",
      manufacturers = [],
      tableState = (initialSort "Manufacturer")
    }
