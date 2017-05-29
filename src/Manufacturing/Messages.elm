module Manufacturing.Messages exposing (..)

import Http

import Manufacturing.Models exposing (Manufacturer)
import Rest exposing (HttpListResponse)


type Msg = GetManufacturersDone (
  Result Http.Error (HttpListResponse Manufacturer))
