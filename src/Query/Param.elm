module Query.Param exposing(QueryParam(..), getKey)


type QueryParam =
  FloatType { key : String, value : Float } |
  IntType { key : String, value : Int } |
  StringType { key : String, value : String }


getKey : QueryParam -> String
getKey param =
  case param of
    FloatType { key, value } -> key
    IntType { key, value } -> key
    StringType { key, value } -> key


getFloat : QueryParam -> Maybe Float
getFloat param =
  case param of
    FloatType { key, value } -> Just value
    IntType { key, value } -> Nothing
    StringType { key, value } -> Nothing


getInt : QueryParam -> Maybe Int
getInt param =
  case param of
    FloatType { key, value } -> Nothing
    IntType { key, value } -> Just value
    StringType { key, value } -> Nothing


getString : QueryParam -> Maybe String
getString param =
  case param of
    FloatType { key, value } -> Nothing
    IntType { key, value } -> Nothing
    StringType { key, value } -> Just value


urlFormat : QueryParam -> String
urlFormat param =
  let
    format = \k v -> k ++ "=" ++ v
  in
    case param of
      FloatType { key, value } -> format key (toString value)
      IntType { key, value } -> format key (toString value)
      StringType { key, value } -> format key value
