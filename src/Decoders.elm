module Decoders exposing (
  driverDecoder, driversDecoder, manufacturersDecoder)

import Json.Decode exposing (
  Decoder, andThen, at, fail, float, int, list, nullable, string, succeed)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)

import Models exposing (..)


dealerDecoder : Decoder Dealer
dealerDecoder = decode Dealer
  |> required "name" string
  |> required "website" string


driverDecoder : Decoder Driver
driverDecoder = decode Driver
  |> requiredAt [ "basket_frame" ] (nullable materialDecoder)
  |> required "bl_product" (nullable stringToFloat)
  |> required "compliance_equivalent_volume" (nullable stringToFloat)
  |> requiredAt [ "cone" ] (nullable materialDecoder)
  |> required "cone_surface_area" (nullable stringToFloat)
  |> required "dc_resistance" (nullable stringToFloat)
  |> required "diaphragm_mass_including_airload" (nullable stringToFloat)
  |> requiredAt [ "driver_product_listings" ] (nullable driverProductListingsDecoder)
  |> required "electromagnetic_q" (nullable stringToFloat)
  |> requiredAt [ "frequency_response" ] (nullable frequencyResponseDecoder)
  |> required "id" int
  |> requiredAt [ "magnet" ] (nullable materialDecoder)
  |> requiredAt [ "manufacturer" ] manufacturerDecoder
  |> required "max_linear_excursion" (nullable stringToFloat)
  |> required "max_power" (nullable int)
  |> required "mechanical_compliance_of_suspension" (nullable stringToFloat)
  |> required "mechanical_q" (nullable stringToFloat)
  |> required "model" string
  |> required "nominal_diameter" (nullable stringToFloat)
  |> required "nominal_impedance" (nullable int)
  |> required "resonant_frequency" (nullable stringToFloat)
  |> required "rms_power" (nullable int)
  |> required "sensitivity" (nullable stringToFloat)
  |> requiredAt [ "surround" ] (nullable materialDecoder)
  |> required "voice_coil_diameter" (nullable stringToFloat)
  |> requiredAt [ "voice_coil_former" ] (nullable materialDecoder)
  |> required "voice_coil_inductance" (nullable stringToFloat)
  |> requiredAt [ "voice_coil_wire" ] (nullable materialDecoder)


driversDecoder : Decoder (List Driver)
driversDecoder =
  list driverDecoder


driverProductListingDecoder : Decoder DriverProductListing
driverProductListingDecoder = decode DriverProductListing
  |> requiredAt [ "dealer" ] dealerDecoder
  |> required "path" string
  |> required "price" stringToFloat



driverProductListingsDecoder : Decoder (List DriverProductListing)
driverProductListingsDecoder =
  list driverProductListingDecoder


frequencyResponseDecoder : Decoder FrequencyResponse
frequencyResponseDecoder = decode FrequencyResponse
  |> required "lower" int
  |> required "upper" int


manufacturerDecoder : Decoder Manufacturer
manufacturerDecoder = decode Manufacturer
  |> required "id" int
  |> required "name" string
  |> required "website" (nullable string)


manufacturersDecoder : Decoder (List Manufacturer)
manufacturersDecoder =
  list manufacturerDecoder


materialDecoder : Decoder Material
materialDecoder = decode Material
  |> required "id" int
  |> required "name" string


-- PRIVATE

stringToFloat : Decoder Float
stringToFloat =
  string |> andThen (\val ->
    case String.toFloat val of
      Ok fl -> succeed fl
      Err err -> fail err)
