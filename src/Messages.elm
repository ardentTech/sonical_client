module Messages exposing (..)

import Debounce exposing (Debounce)
import Http
import Table

import Models exposing (Driver, ListHttpResponse, Manufacturer)


type Msg =
  DebounceMsg Debounce.Msg |
  Fail Http.Error |
  GetDriversDone (Result Http.Error (ListHttpResponse Driver)) |
  GetManufacturersDone (Result Http.Error (ListHttpResponse Manufacturer)) |
  ManufacturerSelected |
  NextPageClicked |
  NoOp |
  PrevPageClicked |
  QueryInput String |
  SetTableState Table.State
