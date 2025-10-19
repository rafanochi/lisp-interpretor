module Main where
import System.Environment
import Text.Printf

main::IO()
main = do
  args <- getArgs
  case args of
    (x:y:_) -> printf "%s * %s = %s\n" x y $ show (read x * read y)
    [x] -> putStrLn $ "Hello, " ++ x
    [] -> putStrLn "no arguments at all"

