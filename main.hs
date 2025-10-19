module Main where
import System.Environment

main::IO()
main = do
  args <- getArgs
  case args of
    (x:y:_) -> putStrLn $ x ++  " * " ++ y ++ " = " ++ show (read x * read y) 
    [x] -> putStrLn $ "Hello, " ++ x
    [] -> putStrLn "no arguments at all"

