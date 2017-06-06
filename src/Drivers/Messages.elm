module Drivers.Messages exposing (..)

import Http
import Table

import Drivers.Models exposing (Driver)
import Rest exposing (HttpListResponse)


type InternalMsg =
  GetDriverDone (Result Http.Error Driver) |
  GetDriversDone (Result Http.Error (HttpListResponse Driver)) |
  NextPageClicked |
  PrevPageClicked |
  QueryBuilderCleared |
  QueryBuilderHelpClicked |
  QueryBuilderSubmitted |
  QueryBuilderUpdated String |
  SetTableState Table.State


type ExternalMsg = NewUrl String


type Msg = ForSelf InternalMsg | ForParent ExternalMsg


type alias Translator msg = Msg -> msg


type alias TranslationDictionary msg = {
  onInternalMessage : InternalMsg -> msg,
  onNewUrl : msg
}


translator : TranslationDictionary msg -> Translator msg
translator { onInternalMessage, onNewUrl } msg =
  case msg of
    ForParent (NewUrl url) ->
      onNewUrl
    ForSelf internal ->
      onInternalMessage internal
