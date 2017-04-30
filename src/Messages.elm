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
  ManufacturerSelected Int |
  NextPageClicked |
  NoOp |
  PrevPageClicked |
  QueryBuilderCleared |
  QueryBuilderUpdated String |
  QueryEntered String |
  SetTableState Table.State
