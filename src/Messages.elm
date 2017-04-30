module Messages exposing (..)

import Debounce exposing (Debounce)
import Http
import Table

import Models exposing (Driver, ListHttpResponse)


type Msg =
  DebounceMsg Debounce.Msg |
  Fail Http.Error |
  GetDriversDone (Result Http.Error (ListHttpResponse Driver)) |
  NextPageClicked |
  NoOp |
  PrevPageClicked |
  QueryBuilderCleared |
  QueryBuilderSubmitted |
  QueryBuilderUpdated String |
  QueryEntered String |
  SetTableState Table.State
