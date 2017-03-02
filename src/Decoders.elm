module Decoders exposing (driverDecoder, driversDecoder)

import Json.Decode exposing (
  Decoder, andThen, at, fail, float, int, list, nullable, string, succeed)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)

import Models exposing (Driver, FrequencyResponse, Manufacturer)


driverDecoder : Decoder Driver
driverDecoder = decode Driver
  |> requiredAt [ "frequency_response" ] frequencyResponseDecoder
  |> required "id" int
  |> requiredAt [ "manufacturer" ] manufacturerDecoder
  |> required "model" string
  |> required "nominal_impedance" (nullable int)
  |> required "resonant_frequency" (nullable stringToFloat)
  |> required "sensitivity" (nullable stringToFloat)


driversDecoder : Decoder (List Driver)
driversDecoder =
  at ["results"] (list driverDecoder)


frequencyResponseDecoder : Decoder FrequencyResponse
frequencyResponseDecoder = decode FrequencyResponse
  |> required "lower" (nullable int)
  |> required "upper" (nullable int)


manufacturerDecoder : Decoder Manufacturer
manufacturerDecoder = decode Manufacturer
  |> required "name" string
  |> required "website" (nullable string)


-- PRIVATE

stringToFloat : Decoder Float
stringToFloat =
  string |> andThen (\val ->
    case String.toFloat val of
      Ok fl -> succeed fl
      Err err -> fail err)
