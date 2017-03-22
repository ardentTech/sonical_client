module Models exposing (..)

import Debounce exposing (Debounce)
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
  debounce : Debounce String,
  drivers : List Driver,
  driversCount : Int,
  driversNextPage : Maybe String,
  driversPreviousPage : Maybe String,
  driversQuery : String,
  manufacturers : List Manufacturer,
  selectedManufacturer : Maybe Int,
  tableState : Table.State
}


defaultModel : Model
defaultModel = {
  apiUrl = "",
  debounce = Debounce.init,
  drivers = [],
  driversCount = 0,
  driversNextPage = Nothing,
  driversPreviousPage = Nothing,
  driversQuery = "",
  manufacturers = [],
  selectedManufacturer = Nothing,
  tableState = (Table.initialSort "Manufacturer")}
