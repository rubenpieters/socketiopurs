module Main where

import Prelude

import Control.Monad.Except.Trans (runExceptT)
import Control.Monad.Eff
import Control.Monad.Eff.Console
import Control.Monad.Eff.Exception (error)
import Control.Monad.Eff.Exception.Unsafe (unsafeThrowException)

import Data.Either
import Data.List.NonEmpty
import Data.Newtype (unwrap)
import Data.Foreign
import Data.Foreign.Class (class Encode, class Decode)
import Data.Foreign.Generic as DFG
import Data.Foreign.Generic (genericEncode, encodeJSON, genericDecode, decodeJSON)
import Data.Generic.Rep as Rep
import Data.Generic.Rep.Show (genericShow)

data MyADT
  = T1 Int
  | T2 String

derive instance genericMyADT :: Rep.Generic MyADT _
instance showMyADT :: Show MyADT
  where show = genericShow
instance encodeMyADT :: Encode MyADT
  where encode = genericEncode $ DFG.defaultOptions
instance decodeMyADT :: Decode MyADT
  where decode = genericDecode $ DFG.defaultOptions

showMyAdt :: MyADT -> String
showMyAdt = show

encodeMyAdt :: MyADT -> String
encodeMyAdt = encodeJSON

decodeMyAdt :: String -> Either (NonEmptyList ForeignError) MyADT
decodeMyAdt s = unwrap $ runExceptT $ decodeJSON s

decodeMyAdtOrThrow :: String -> Eff (console :: CONSOLE) MyADT
decodeMyAdtOrThrow s = do
  case (decodeMyAdt s) of
    (Left errList) -> do
      unsafeThrowException (error "error decoding MyADT")
    (Right value) -> pure value

main :: ∀ e. Eff (console :: CONSOLE | e) Unit
main = do
  log "running"
  pure unit
