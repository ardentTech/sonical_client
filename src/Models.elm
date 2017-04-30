module Models exposing (..)

import Table


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
  drivers : List Driver,
  driversCount : Int,
  driversNextPage : Maybe String,
  driversPreviousPage : Maybe String,
  driversQuery : String,
  tableState : Table.State
}


defaultModel : Model
defaultModel = {
  apiUrl = "",
  drivers = [],
  driversCount = 0,
  driversNextPage = Nothing,
  driversPreviousPage = Nothing,
  driversQuery = "",
  tableState = (Table.initialSort "Manufacturer")}
