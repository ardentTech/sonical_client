module Config exposing (debounceConfig)

import Debounce exposing (Debounce)
import Time exposing (second)

import Messages exposing (Msg (DebounceMsg))


debounceConfig : Debounce.Config Msg
debounceConfig = {
  strategy = Debounce.later (0.5 * second),
  transform = DebounceMsg }
