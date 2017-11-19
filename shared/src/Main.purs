module Main where

import Prelude

data MyADT
  = T1 Int
  | T2 String

showMyAdt :: MyADT -> String
showMyAdt (T1 x) = "(T1 " <> show x <> ")"
showMyAdt (T2 x) = "(T2 " <> show x <> ")"
