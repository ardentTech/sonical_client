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
-- basket_frame, bl_product, compliance_equivalent_volume, cone, cone_surface_area,
-- dc_resistance, diaphragm_mass_including_airload, driver_product_listings,
-- electromagnetic_q, in_production, magnet,
-- max_linear_excursion, mechanical_compliance_of_suspension,
-- mechanical_q,
-- surround, voice_coil_diameter, voice_coil_former,
-- voice_coil_inductance, voice_coil_wire


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
