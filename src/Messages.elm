module Messages exposing (..)

import Debounce exposing (Debounce)
import Http
import Table

import Models exposing (ListHttpResponse)


type Msg =
  DebounceMsg Debounce.Msg |
  Fail Http.Error |
  GetDriversDone (Result Http.Error ListHttpResponse) |
  NextPageClicked |
  NoOp |
  PrevPageClicked |
  QueryInput String |
  SetTableState Table.State
