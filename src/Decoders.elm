module Decoders exposing (
  httpResponseListDecoder, driversDecoder, manufacturersDecoder)

import Json.Decode exposing (
  Decoder, andThen, at, fail, float, int, list, nullable, string, succeed)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)

import Models exposing (..)


driverDecoder : Decoder Driver
driverDecoder = decode Driver
  |> required "bl_product" (nullable stringToFloat)
  |> required "compliance_equivalent_volume" (nullable stringToFloat)
  |> required "cone_surface_area" (nullable stringToFloat)
  |> required "dc_resistance" (nullable stringToFloat)
  |> required "diaphragm_mass_including_airload" (nullable stringToFloat)
  |> required "electromagnetic_q" (nullable stringToFloat)
  |> requiredAt [ "frequency_response" ] (nullable frequencyResponseDecoder)
  |> required "id" int
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
  |> required "voice_coil_diameter" (nullable stringToFloat)
  |> required "voice_coil_inductance" (nullable stringToFloat)


driversDecoder : Decoder (List Driver)
driversDecoder =
  list driverDecoder


frequencyResponseDecoder : Decoder FrequencyResponse
frequencyResponseDecoder = decode FrequencyResponse
  |> required "lower" int
  |> required "upper" int


httpResponseListDecoder : Decoder (List a) -> Decoder (ListHttpResponse a)
httpResponseListDecoder listDecoder = decode ListHttpResponse
  |> required "count" int
  |> required "next" (nullable string)
  |> required "previous" (nullable string)
  |> required "results" listDecoder


manufacturerDecoder : Decoder Manufacturer
manufacturerDecoder = decode Manufacturer
  |> required "id" int
  |> required "name" string
  |> required "website" (nullable string)


manufacturersDecoder : Decoder (List Manufacturer)
manufacturersDecoder =
  list manufacturerDecoder


-- PRIVATE

stringToFloat : Decoder Float
stringToFloat =
  string |> andThen (\val ->
    case String.toFloat val of
      Ok fl -> succeed fl
      Err err -> fail err)
