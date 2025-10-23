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
  deriving (Show)

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

spaces :: Parser ()
spaces = skipMany1 space

charWithEsc :: Parser Char
charWithEsc = do
  _ <- char '\\'
  oneOf "\""

parseString :: Parser LispVal
parseString = do
  _ <- char '"'
  x <- many (charWithEsc <|> noneOf "\"")
  _ <- char '"'
  return $ LString x

parseAtom :: Parser LispVal
parseAtom = do
  first <- letter <|> symbol
  rest <- many (letter <|> digit <|> symbol)
  let atom = first : rest
  return $ case atom of
    "#t" -> LBool True
    "#f" -> LBool False
    _ -> Atom atom

parseNumber :: Parser LispVal
parseNumber = many1 digit >>= \x -> return $ (LNumber . read) x

parseExpr :: Parser LispVal
parseExpr = parseString <|> parseNumber <|> parseAtom

readExpr :: String -> String
readExpr input = case parse parseExpr "lisp" input of
  Left err -> "No match: " ++ show err
  Right x -> "Found value: " ++ show x

main :: IO ()
main = do
  (expr : _) <- getArgs
  case parse parseExpr "lisp" expr of
    Right (LString s) -> do
      putStrLn ("Parsed string: " ++ s) -- prints actual characters
      putStrLn ("Char list: " ++ show (map (:[]) s))
      putStrLn ("Parsed String length: " ++ show (length s))
    other -> print other
