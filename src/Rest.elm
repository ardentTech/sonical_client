module Rest exposing (getList)

import Http
import Json.Decode exposing (Decoder)
import Result exposing (Result)

import Decoders exposing (httpListResponseDecoder)
import Models exposing (HttpListResponse)


getList : String -> Decoder (List a) -> (Result Http.Error (HttpListResponse a) -> b) -> Cmd b
getList url listDecoder resultToMsg =
  Http.send resultToMsg <| Http.get url (httpListResponseDecoder listDecoder)
