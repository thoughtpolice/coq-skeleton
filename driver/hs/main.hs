module Main
       ( main -- :: IO ()
       ) where

import qualified Mod1 (main)

main :: IO ()
main = print (Mod1.main 10)
