module Messages exposing (..)

import Debounce exposing (Debounce)
import Http
import Table

import Models exposing (HttpResponse)


type Msg =
  DebounceMsg Debounce.Msg |
  Fail Http.Error |
  GetDriversDone (Result Http.Error HttpResponse) |
  NextPageClicked |
  NoOp |
  PrevPageClicked |
  QueryInput String |
  SetTableState Table.State
