module Models exposing (..)

import Table

import Router exposing (Route (DriverList))


type alias Dealer = {
  name : String,
  website : String
}


type alias Driver = {
  basket_frame : Maybe Material,
  bl_product : Maybe Float,
  compliance_equivalent_volume : Maybe Float,
  cone : Maybe Material,
  cone_surface_area : Maybe Float,
  dc_resistance : Maybe Float,
  diaphragm_mass_including_airload : Maybe Float,
  driver_product_listings : Maybe (List DriverProductListing),
  electromagnetic_q : Maybe Float,
  frequency_response : Maybe FrequencyResponse,
  id : Int,
  magnet : Maybe Material,
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
  surround : Maybe Material,
  voice_coil_diameter : Maybe Float,
  voice_coil_former : Maybe Material,
  voice_coil_inductance : Maybe Float,
  voice_coil_wire : Maybe Material
}


type alias DriverProductListing = {
  dealer : Dealer,
  path : String,
  price : Float
}


type alias FrequencyResponse = {
  lower : Int,
  upper : Int
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
