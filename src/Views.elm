module Views exposing (view)

import Html exposing (Html, button, div, h3, table, tbody, td, text, thead, th, tr)
import Html.Attributes exposing (class, disabled, id, title)
import Html.Events exposing (onClick)
import List exposing (map, length)
import String exposing (toLower)
import Table

import Messages exposing (
  Msg (NextPageClicked, PrevPageClicked, SetTableState, TableHeaderClicked))
import Models exposing (Driver, FrequencyResponse, Model)
import TypeConverters exposing (maybeNumToNum, maybeNumToStr, maybeStrToStr)
import Units exposing (decibels, hertz, ohms, watts)


config : Table.Config Driver Msg
config =
  Table.config {
    toId = .model,
    toMsg = SetTableState,
    columns = [
      Table.stringColumn "Model" .model
    ]
  }


view : Model -> Html Msg
view model =
  div [] [ Table.view config model.tableState model.drivers ]


--viewz : Model -> Html Msg
--viewz model = 
--  div [ class "row" ] [
--    div [ class "col-12", id "drivers" ] [
--      h3 [] [ text "Drivers" ],
--      table [ class "table table-sm table-striped" ] [
--        tableHeader,
--        tableBody model
--      ]
--    ],
--    div [ class "col-6 text-muted", id "pagination-info" ] [
--      paginationInfo model
--    ],
--    div [ class "col-6", id "pagination-controls" ] [
--      paginationControls model
--    ]
--  ]
--
--
---- PRIVATE
--
--type alias TableHeaderCell = { text : String, title : Maybe String }
--
--
--frequencyResponseCell : Driver -> Html Msg
--frequencyResponseCell driver =
--  let
--    lower = maybeNumToStr <| driver.frequency_response.lower
--    upper = maybeNumToStr <| driver.frequency_response.upper
--    str = lower ++ "-" ++ upper ++ hertz
--  in
--    td [] [ text str ] 
--
--
--manufacturerCell : Driver -> Html Msg
--manufacturerCell driver =
--  td [] [ text driver.manufacturer.name ]
--
--
--modelCell : Driver -> Html Msg
--modelCell driver =
--  td [] [ text driver.model ]
--
--
--nextPage : Model -> Html Msg
--nextPage model =
--  page model.driversNextPage NextPageClicked "»"
--
--
--nominalImpedanceCell : Driver -> Html Msg
--nominalImpedanceCell driver =
--  let
--    str = (maybeNumToStr driver.nominal_impedance) ++ ohms
--  in
--    td [] [ text str ]
--
--
--page : Maybe String -> Msg -> String -> Html Msg
--page endpoint msg txt =
--  let
--    disabledVal =
--      case endpoint of
--        Nothing -> True
--        Just v -> False
--  in
--    button [
--      class "btn btn-secondary btn-sm text-muted",
--      disabled disabledVal,
--      onClick msg
--    ] [ text txt ]
--
--
--paginationControls : Model -> Html Msg
--paginationControls model =
--  let
--    prev = prevPage model
--    next = nextPage model
--  in
--    div [ class "btn-group float-right", id "pagination" ] [ prev, next ]
--
--
--paginationInfo : Model -> Html Msg
--paginationInfo model =
--  let
--    currentCount = (toString <| length model.drivers)
--    totalCount = (toString model.driversCount)
--  in
--    text <| "Showing " ++ currentCount ++ " of " ++ totalCount ++ " items"
--
--
--power : Maybe number -> String
--power n =
--  maybeNumToStr n ++ watts
--
--
--maxPowerCell : Driver -> Html Msg
--maxPowerCell driver =
--  td [] [ text <| power driver.max_power ]
--
--
--rmsPowerCell : Driver -> Html Msg
--rmsPowerCell driver =
--  td [] [ text <| power driver.rms_power ]
--
--
--prevPage : Model -> Html Msg
--prevPage model =
--  page model.driversPreviousPage PrevPageClicked "«"
--
--
--resonantFrequencyCell : Driver -> Html Msg
--resonantFrequencyCell driver =
--  let
--    str = (maybeNumToStr driver.resonant_frequency) ++ hertz
--  in
--    td [] [ text str ]
--
--
--sensitivityCell : Driver -> Html Msg
--sensitivityCell driver =
--  let
--    str = (maybeNumToStr driver.sensitivity) ++ decibels
--  in
--    td [] [ text str ]
--
--
--tableBody : Model -> Html Msg
--tableBody model =
--  tbody [] (map tableBodyRow model.drivers)
--
--
--tableBodyRow : Driver -> Html Msg
--tableBodyRow driver =
--  let
--    cells = [
--      manufacturerCell,
--      modelCell,
--      nominalImpedanceCell,
--      resonantFrequencyCell,
--      frequencyResponseCell,
--      sensitivityCell,
--      maxPowerCell,
--      rmsPowerCell
--    ]
--  in
--    tr [] (map (\c -> c driver) cells)
--
--
--tableHeader : Html Msg
--tableHeader =
--  thead [] [ tr [] tableHeaderCells ]
--
--
--tableHeaderCells : List (Html Msg)
--tableHeaderCells =
--  let
--    cells = [
--      TableHeaderCell "Manufacturer" Nothing,
--      TableHeaderCell "Model" Nothing,
--      TableHeaderCell "Z" (Just "Nominal Impedance"),
--      TableHeaderCell "Fs" (Just "Resonant Frequency"),
--      TableHeaderCell "Sensitivity" Nothing,
--      TableHeaderCell "Fr" (Just "Frequency Response"),
--      TableHeaderCell "Max" (Just "Power"),
--      TableHeaderCell "RMS" (Just "Power")
--    ]
--  in
--    map tableHeaderCell cells
--
--
--tableHeaderCell : TableHeaderCell -> Html Msg
--tableHeaderCell cell =
--  let
--    columnId = toLower cell.text
--    attrs = [
--      id <| columnId,
--      onClick (TableHeaderClicked columnId),
--      title <| maybeStrToStr cell.title
--    ]
--  in
--    th attrs [ text cell.text ]
