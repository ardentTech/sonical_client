module Decoders exposing (httpResponseDecoder, driverDecoder, driversDecoder)

import Json.Decode exposing (
  Decoder, andThen, at, fail, float, int, list, nullable, string, succeed)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)

import Models exposing (..)


driverDecoder : Decoder Driver
driverDecoder = decode Driver
  |> requiredAt [ "frequency_response" ] frequencyResponseDecoder
  |> required "id" int
  |> requiredAt [ "manufacturer" ] manufacturerDecoder
  |> required "max_power" (nullable int)
  |> required "model" string
  |> required "nominal_diameter" (nullable stringToFloat)
  |> required "nominal_impedance" (nullable int)
  |> required "resonant_frequency" (nullable stringToFloat)
  |> required "rms_power" (nullable int)
  |> required "sensitivity" (nullable stringToFloat)


driversDecoder : Decoder (List Driver)
driversDecoder =
  list driverDecoder


frequencyResponseDecoder : Decoder FrequencyResponse
frequencyResponseDecoder = decode FrequencyResponse
  |> required "lower" (nullable int)
  |> required "upper" (nullable int)


httpResponseDecoder : Decoder ListHttpResponse
httpResponseDecoder = decode ListHttpResponse
  |> required "count" int
  |> required "next" (nullable string)
  |> required "previous" (nullable string)
  |> required "results" driversDecoder


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
