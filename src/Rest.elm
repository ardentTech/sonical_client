module Rest exposing (getList)

import Http
import Json.Decode exposing (Decoder)
import Result exposing (Result)

import Decoders exposing (httpResponseListDecoder)
import Models exposing (ListHttpResponse)


getList : String -> Decoder (List a) -> (Result Http.Error (ListHttpResponse a) -> b) -> Cmd b
getList url listDecoder resultToMsg =
  Http.send resultToMsg <| Http.get url (httpResponseListDecoder listDecoder)
