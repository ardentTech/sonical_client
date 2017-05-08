module Models exposing (..)

import Table

import Router exposing (Route (DriverList))


type alias Driver = {
  bl_product : Maybe Float,
  compliance_equivalent_volume : Maybe Float,
  cone_surface_area : Maybe Float,
  dc_resistance : Maybe Float,
  diaphragm_mass_including_airload : Maybe Float,
  electromagnetic_q : Maybe Float,
  frequency_response : Maybe FrequencyResponse,
  id : Int,
  manufacturer : Manufacturer,
  max_linear_excursion : Maybe Float,
  max_power : Maybe Int,
  mechanical_compliance_of_suspension : Maybe Float,
  mechanical_q : Maybe Float,
  model : String,
  nominal_diameter : Maybe Float,
  nominal_impedance : Maybe Int,
  resonant_frequency : Maybe Float,
  rms_power : Maybe Int,
  sensitivity : Maybe Float,
  voice_coil_diameter : Maybe Float,
  voice_coil_inductance : Maybe Float
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


type alias Material = {
  id : Int,
  name : String
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
