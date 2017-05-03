module Models exposing (..)

import Table

import Router exposing (Route (DriverList))


type alias Driver = {
  frequency_response : Maybe FrequencyResponse,
  id : Int,
  manufacturer : Manufacturer,
  max_power : Maybe Int,
  model : String,
  nominal_diameter : Maybe Float,
  nominal_impedance : Maybe Int,
  resonant_frequency : Maybe Float,
  rms_power : Maybe Int,
  sensitivity : Maybe Float
}


type alias FrequencyResponse = {
  lower : Int,
  upper : Int
}


type alias ListHttpResponse a = {
  count : Int,
  next : Maybe String,
  previous : Maybe String,
  results : List a
}


type alias Manufacturer = {
  id : Int,
  name : String,
  website : Maybe String
}


type alias Model = {
  apiUrl : String,
  currentRoute : Maybe Route,
  drivers : List Driver,
  driversCount : Int,
  driversNextPage : Maybe String,
  driversPreviousPage : Maybe String,
  driversQuery : String,
  errorMessage : String,  -- @todo call this 'error' instead
  tableState : Table.State
}


-- @todo should be an empty/null model that is populated inside of Main.elm
defaultModel : Model
defaultModel = {
  apiUrl = "",
  currentRoute = Just DriverList,
  drivers = [],
  driversCount = 0,
  driversNextPage = Nothing,
  driversPreviousPage = Nothing,
  driversQuery = "",
  errorMessage = "",
  tableState = (Table.initialSort "Manufacturer")}
