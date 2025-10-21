module Main where

import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)

data LispVal
  = Atom String
  | LList [LispVal]
  | LDottedList [LispVal] LispVal
  | LNumber Integer
  | LString String
  | LBool Bool

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

readExpr :: String -> String
readExpr input = case parse (spaces >> symbol) "lisp" input of
  Left err -> "No match: " ++ show err
  Right _ -> "Found value!"

spaces :: Parser ()
spaces = skipMany1 space

parseString :: Parser LispVal
parseString = do
  _ <- char '"'
  x <- many (noneOf "\"")
  _ <- char '"'
  return $ LString x

main :: IO ()
main = do
  (expr : _) <- getArgs
  putStrLn (readExpr expr)
