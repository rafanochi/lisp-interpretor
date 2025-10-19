module Main where
import System.Environment

main::IO()
main = do
  args <- getArgs
  case args of
    (x:y:_) -> putStrLn $ "Hello, " ++ x ++ y
    [x] -> putStrLn $ "Hello, " ++ x
    [] -> putStrLn "no arguments at all"

