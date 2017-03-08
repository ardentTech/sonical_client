module Models exposing (..)

import Table


type alias Driver = {
  frequency_response : FrequencyResponse,
  id : Int,
  manufacturer : Manufacturer,
  max_power : Maybe Int,
  model : String,
  nominal_impedance : Maybe Int,
  resonant_frequency : Maybe Float,
  rms_power : Maybe Int,
  sensitivity : Maybe Float
}


type alias FrequencyResponse = {
  lower : Maybe Int,
  upper : Maybe Int
}


type alias HttpResponse = {
  count : Int,
  next : Maybe String,
  previous : Maybe String,
  results : List Driver
}


type alias Manufacturer = {
  name : String,
  website : Maybe String
}


type alias Model = {
  drivers : List Driver,
  driversCount : Int,
  driversNextPage : Maybe String,
  driversPreviousPage : Maybe String,
  tableState : Table.State
}


defaultModel : Model
defaultModel =
  Model [] 0 Nothing Nothing (Table.initialSort "Manufacturer")
