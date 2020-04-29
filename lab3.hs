import Prelude hiding (Word)
import Control.Monad (msum, foldM)
import Data.Maybe (catMaybes, isJust, fromJust)
import Data.List (map, filter, elem, transpose, find)
import Data.Map (Map, (!))
import qualified Data.Map as Map (lookup, member, fromList, toList)
import Data.Set (Set)
import qualified Data.Set as Set 
  (map, filter, null, empty, union, unions, 
  member, insert, difference, toList, fromList)

type State = Char
type Letter = Char
type Word = [Letter]
type Delta = Map State (Map Letter State)
type DeltaExtendable = Map State (Map [Letter] State)

_Σ :: [Letter]
_Σ = ['a', 'b', 'c', 'd', 'v','w']                                 -- alphabet

_S :: [State]
_S = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L']  -- states

s_0 :: State
s_0 = 'A'                                                          -- initial state

_F :: [State]
_F = ['K', 'F']                                                    -- final states

v :: Word
v = "v"

w :: Word
w = "w"

delta :: Delta
delta = 
  Map.fromList 
    [('A', Map.fromList[('v', 'B')]),
    ('B', Map.fromList[('a', 'C'), ('w', 'F')]),
    ('C', Map.fromList[('b', 'D'), ('d', 'E')]),
    ('D', Map.fromList[('c', 'B')]),
    ('E', Map.fromList[('c', 'B'), ('w', 'I')]),
    ('F', Map.fromList[('a', 'G')]),
    ('G', Map.fromList[('b', 'H'), ('c', 'L')]),
    ('H', Map.fromList[('c', 'I')]),
    ('I', Map.fromList[('a', 'J')]),
    ('J', Map.fromList[('d', 'K')]),
    ('K', Map.fromList[('c', 'F')]),
    ('L', Map.fromList[('b', 'H')])]

eat :: Word -> State -> Maybe State
eat word curr_state = 
  foldM 
    (\state letter ->
      let transitions = Map.lookup state delta in
      if (isJust transitions)
        then Map.lookup letter (fromJust transitions)
        else Nothing)
    curr_state word

reachable :: Delta -> State -> [State]
reachable delta state = reachable' delta Set.empty $ 
  Set.fromList $ map snd $ Map.toList (delta ! state)

reachable' :: Delta -> Set State -> Set State -> [State]
reachable' delta we_was we_wasnt = 
  (Set.toList we_wasnt) ++ 
    if Set.null we_wasnt' 
      then [] 
      else reachable' delta we_was' we_wasnt' 
  where we_was' = Set.union we_was we_wasnt
        we_wasnt' = 
          (Set.unions $ Set.toList $ Set.map 
            (\s -> Set.fromList $ Prelude.map snd $ Map.toList (delta ! s)) 
            we_wasnt)
          Set.difference 
          we_was'

get_moves :: Delta -> State -> [Set (Letter, State)]
get_moves delta state = 
  [Set.fromList m | 
    m <- iterate 
      (\transitions -> 
        concatMap 
          (\(word, state') -> Map.toList $ delta ! state') 
          transitions) 
      (Map.toList $ delta ! state)]
     
get_moves_path :: DeltaExtendable -> State -> [Set (Word, State)]
get_moves_path delta_extendable state = 
  [Set.fromList m | 
    m <- iterate 
      (\transitions -> 
        concatMap 
          (\(word, state') -> 
            map 
              (\(letter, state) -> (word ++ letter, state)) $
              Map.toList $ delta_extendable ! state') 
          transitions) 
      (Map.toList $ delta_extendable ! state)]

search_word_ends :: String -> Word -> [(State, State)]
search_word_ends word nodes = 
  (catMaybes $ map 
    (\word_first ->
      let word_last = eat word word_first in
      if isJust word_last 
        then Just (word_first, fromJust word_last) 
        else Nothing)
    nodes)

takeHelper :: 
  [(State, [State])] -> 
  [(Set (Letter, State), [Set (Word, State)])] -> 
  Maybe Word
takeHelper ends' (x:xs) = 
  if (\(main_moves, other_moves) -> all Set.null other_moves) x
    then Nothing
    else
      if (\(main_moves, other_moves) -> 
        any 
          (\(end, move) -> 
            any 
              (\(letter, state) -> 
                (elem state (snd end)) && 
                (any 
                  (\(letter, state) -> state == fst end) 
                  main_moves)) 
              move) 
          (zip ends' other_moves)) x
        then Just $
          (\(main_moves, other_moves) -> 
            fst $ fromJust $ msum $ map 
              (\(end, move) -> 
                find 
                  (\(letter, state) -> 
                    (elem state (snd end)) && 
                    (any 
                      (\(letter, state) -> state == fst end) 
                      main_moves)) 
                  move) 
              (zip ends' other_moves)) x
        else takeHelper ends' xs

main = do
  case eat v s_0 of
    Nothing -> putStrLn "Can not eat v"
    Just y_s_0 -> do
      let
        ends :: [(State, State)]
        ends = search_word_ends w $ reachable delta y_s_0

        ends' :: [(State, [State])]
        ends' = 
          map 
            (\end -> 
              (fst end, 
              filter 
                (\end_reachable -> elem end_reachable _F) $ 
                reachable delta (snd end))) 
            ends

        delta_extendable :: DeltaExtendable
        delta_extendable = 
          Map.fromList 
            [(state, 
              Map.fromList [([letter], state') | 
                (letter, state') <- Map.toList transitions]) | 
                  (state, transitions) <- Map.toList delta]
        
        other_auto_moves :: [[Set (Word, State)]]
        other_auto_moves = 
          [move | 
            move <- 
              transpose $ map
                (\q -> get_moves_path delta_extendable (snd q))
                ends]
        
        main_auto_moves :: [Set (Letter, State)]
        main_auto_moves = get_moves delta y_s_0
        
        sync_moves :: [(Set (Letter, State), [Set (Word, State)])]
        sync_moves = zip main_auto_moves other_auto_moves
        
        common_sync_moves :: [(Set (Letter, State), [Set (Word, State)])]
        common_sync_moves = 
          map 
            (\(main_moves, other_moves) -> 
              (main_moves,
               map 
                 (Set.filter 
                   (\(word, state) -> 
                     any 
                       (\(letter, state) -> letter == last word) 
                       main_moves)) 
                 other_moves)) 
            sync_moves

      print $ y_s_0
      putStrLn ""

      print $ ends
      print $ ends'

      if all (\end -> null $ snd end) ends' 
        then putStrLn "No"
        else do
          putStrLn ""

          sequence_ $ map print $ take 10 $ sync_moves
          putStrLn ""

          sequence_ $ map print $ take 10 $ common_sync_moves  
          putStrLn ""  

          case takeHelper ends' common_sync_moves of
              Just answer -> print answer
              Nothing -> putStrLn "No"
