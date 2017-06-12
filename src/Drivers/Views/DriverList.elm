module Drivers.Views.DriverList exposing (driverList)

import Html exposing (Html, a, button, div, text)
import Html.Attributes exposing (class, disabled, id, placeholder, type_, value)
import Html.Events exposing (onClick)
import Table exposing (defaultCustomizations)

import Drivers.Messages exposing (..)
import Drivers.Models exposing (Driver)
import Drivers.Views.QueryBuilder exposing (queryBuilder)
import Models exposing (Model)
import TypeConverters exposing (maybeFloatToFloat, maybeIntToInt)
import Units exposing (decibels, hertz, inches, numAppendUnit, ohms, watts)
import Views.Loading exposing (loading)


driverList : Model -> Html Msg
driverList model =
  case (List.length model.drivers) of
    0 -> loading
    _ -> withDrivers model


withDrivers : Model -> Html Msg
withDrivers model =
  div [ class "row" ] [
    div [ class "col-12" ] [
      queryBuilder model,
      Table.view tableConfig model.tableState model.drivers
    ], 
    div [ class "col-6", id "pagination-info" ] [ paginationInfo model ],
    div [ class "col-6", id "pagination-controls" ] [ paginationControls model ]
  ]


-- PRIVATE

manufacturerColumn : Table.Column Driver Msg
manufacturerColumn =
  Table.stringColumn "Manufacturer" ((\m -> m.name) << .manufacturer)

maybeFloatColumn : String -> (Driver -> Maybe Float) -> String -> Table.Column Driver Msg
maybeFloatColumn name toData unit =
  let
    data = maybeFloatToFloat << toData
    formatData = (\d -> if d > 0 then (numAppendUnit d unit) else "-")
    vData = (\v -> formatData (data v))
  in
    Table.customColumn {
      name = name,
      viewData = vData,
      sorter = Table.increasingOrDecreasingBy data 
    }

maybeIntColumn : String -> (Driver -> Maybe Int) -> String -> Table.Column Driver Msg
maybeIntColumn name toData unit =
  let
    data = maybeIntToInt << toData
    formatData = (\d -> if d > 0 then (numAppendUnit d unit) else "-")
    vData = (\v -> formatData (data v))
  in
    Table.customColumn {
      name = name,
      viewData = vData,
      sorter = Table.increasingOrDecreasingBy data 
    }


modelColumn : Table.Column Driver Msg
modelColumn =
  Table.veryCustomColumn {
    name = "Model",
    viewData = viewModel,
    sorter = Table.unsortable
  }


paginationControl : Maybe String -> Msg -> String -> Html Msg
paginationControl endpoint msg txt =
  let
    disabledVal =
      case endpoint of
        Nothing -> True
        Just e -> False
  in
    button [
      class "btn btn-secondary btn-sm text-muted",
      disabled disabledVal,
      onClick msg
    ] [ text txt ]


paginationControls : Model -> Html Msg
paginationControls model =
  let
    prev = paginationControl Nothing (ForSelf PrevPageClicked) "«"
    next = paginationControl Nothing (ForSelf NextPageClicked) "»"
  in
    div [ class "btn-group float-right" ] [ prev, next ]


paginationInfo : Model -> Html Msg
paginationInfo model =
  let
    currentCount = (toString <| List.length model.drivers)
    totalCount = (toString model.driversCount)
  in
    div [ class "text-muted" ] [
      text <| "Showing " ++ currentCount ++ " of " ++ totalCount ++ " items"
    ]


tableConfig : Table.Config Driver Msg
tableConfig =
  Table.customConfig {
    toId = .model,
    toMsg = ForSelf << SetTableState,
    columns = [
      modelColumn,
      manufacturerColumn,
      maybeFloatColumn "Diam" .nominal_diameter inches,
      maybeFloatColumn "Fs" .resonant_frequency hertz,
      maybeFloatColumn "SPL" .sensitivity decibels,
      maybeIntColumn "Z"  .nominal_impedance ohms,
      maybeIntColumn "Max P" .max_power watts,
      maybeIntColumn "RMS P" .rms_power watts ],
    customizations = {
      defaultCustomizations | tableAttrs = [ class "table table-sm table-striped" ]
    }
  }


viewModel : Driver -> Table.HtmlDetails Msg
viewModel {id, model} =
  let
    limit = 30
    txt = (String.left limit model) ++ (if (String.length model > limit) then "..." else "")
  in
    Table.HtmlDetails [ class "col-driver-model" ] [
      a [ onClick (ForParent (NewUrl ("drivers/" ++ (toString id))))] [ text txt ]]
