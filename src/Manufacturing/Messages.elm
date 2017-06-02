module Manufacturing.Messages exposing (..)

import Http

import Manufacturing.Models exposing (Manufacturer)
import Rest exposing (HttpListResponse)


type InternalMsg = NoOp | GetManufacturersDone (
  Result Http.Error (HttpListResponse Manufacturer))


type Msg = ForSelf InternalMsg


type alias Translator msg = Msg -> msg


type alias TranslationDictionary msg = {
  onInternalMessage : InternalMsg -> msg
}


translator : TranslationDictionary msg -> Translator msg
translator { onInternalMessage } msg =
  case msg of
    ForSelf internal ->
      onInternalMessage internal
