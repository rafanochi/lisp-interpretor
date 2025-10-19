module Main where
import System.Environment
import Text.Printf

main::IO()
main = do
  putStrLn "Enter your name: "
  name <- getLine 
  putStrLn $ "your name is " ++ name
