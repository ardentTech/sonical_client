module Models exposing (..)

import Table

import Drivers.Models exposing (Driver)
import Manufacturing.Models exposing (Manufacturer)
import Router exposing (Route (DriverList))


type alias Model = {
  apiUrl : String,
  currentRoute : Maybe Route,
  driver : Maybe Driver,
  drivers : List Driver,
  driversCount : Int,
  driversNextPage : Maybe String,
  driversPreviousPage : Maybe String,
  driversQuery : String,
  driversQueryBuilderHelp : Bool,
  errorMessage : String,  -- @todo call this 'error' instead
  manufacturers : List Manufacturer,
  tableState : Table.State
}


-- @todo nest driver/s inside a datastore type or something
-- @todo should be an empty/null model that is populated inside of Main.elm
defaultModel : Model
defaultModel = {
  apiUrl = "",
  currentRoute = Nothing,
  driver = Nothing,
  drivers = [],
  driversCount = 0,
  driversNextPage = Nothing,
  driversPreviousPage = Nothing,
  driversQuery = "",
  driversQueryBuilderHelp = False,
  errorMessage = "",
  manufacturers = [],
  tableState = (Table.initialSort "Manufacturer")}
