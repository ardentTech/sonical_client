module Models exposing (Model)

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
  error : String,
  manufacturers : List Manufacturer,
  tableState : Table.State
}
