module Functions where

    -- Exercise 1
    insertAt :: Int -> a -> [a] -> [a]
    insertAt 1 x ys = x : ys
    insertAt n x (y:ys) = y : insertAt (n-1) x ys
    insertAt n x [] = error "Not enough objects in list!"

    -- Exercise 2
    deleteAt :: Int -> [a] -> [a]
    deleteAt 1 (x:xs) = xs
    deleteAt n (x:xs) = x : deleteAt (n-1) xs
    deleteAt n [] = error "Not enough objects in list!"

    -- Exercise 3
    takeUpTo :: Int -> [a] -> [a]
    takeUpTo 1 (x:xs) = [x]
    takeUpTo n (x:xs) = x : takeUpTo (n-1) xs
    takeUpTo n [] = error "Not enough objects in list!"

    -- Exercise 4
    takeAfter :: Int -> [a] -> [a]
    takeAfter 1 (x:xs) = xs
    takeAfter n (x:xs) = takeAfter (n-1) xs
    takeAfter n [] = error "Not enough objects in list!"

    -- Exercise 5
    takeBetween :: Int -> Int -> [a] -> [a]
    takeBetween n m xs = takeAfter (n-1) (takeUpTo m xs)

    -- Exercise 6
    takeBetween2 :: Int -> Int -> [a] -> [a]
    takeBetween2 1 1 (x:xs) = [x]
    takeBetween2 1 m (x:xs) = x : takeBetween2 1 (m-1) xs
    takeBetween2 n m (x:xs) = takeBetween2 (n-1) (m-1) xs
    takeBetween2 n m [] = error "Not enough objects in list!"

    -- Exercise 7
    allFst :: [(a,b)] -> [a]
    allFst [] = []
    allFst (x:xs) = fst x : allFst xs

    allSnd :: [(a,b)] -> [b]
    allSnd [] = []
    allSnd (x:xs) = snd x : allSnd xs

    allFstMap :: [(a,b)] -> [a]
    allFstMap xs = map fst xs

    allSndMap :: [(a,b)] -> [b]
    allSndMap xs = map snd xs

    allFstComprehension :: [(a,b)] -> [a]
    allFstComprehension xs = [x | (x,y) <- xs]

    allSndComprehension :: [(a,b)] -> [b]
    allSndComprehension xs = [y | (x,y) <- xs]

    -- Functions taken from 3rd week's 11th & 12th exercises
    uniqueList :: (Eq a) => [a] -> [a]
    uniqueList [] = []
    uniqueList (x:xs)
      | elem x xs = uniqueList xs
      | otherwise = x : uniqueList xs

    subset :: (Eq a) => [a] -> [a] -> Bool
    subset [] ys = True
    subset (x:xs) ys
      | elem x ys = subset xs ys
      | otherwise = False

    setEquality :: (Eq a) => [a] -> [a] -> Bool
    setEquality xs ys = subset xs ys && subset ys xs

    -- Exercise 8
    allDifferent :: (Eq a) => [a] -> Bool
    allDifferent [] = True
    allDifferent (x:xs)
      | elem x xs = False
      | otherwise = allDifferent xs

    -- Exercise 9
    isFn :: (Eq a, Eq b) => [(a,b)] -> [a] -> [b] -> Bool
    isFn fs xs ys = setEquality (uniqueList (allFst fs)) (uniqueList xs) && allDifferent (allFst (uniqueList fs)) && subset (uniqueList (allSnd fs)) ys

    -- Exercise 10
    mapTo :: (Eq a, Eq b) => [(a,b)] -> b -> [a]
    mapTo [] y = []
    mapTo (x:xs) y
      | snd x == y = fst x : mapTo xs y
      | otherwise = mapTo xs y

    -- Exercise 11
    areListsWithOneElementOnly :: [[a]] -> Bool
    areListsWithOneElementOnly x = filter (>1) (map length x) == []

    -- Exercise 12
    isInjection :: (Eq a, Eq b) => [(a,b)] -> [a] -> [b] -> Bool
    isInjection fs xs ys = isFn fs xs ys && areListsWithOneElementOnly (map (mapTo fs) ys)

    -- Exercise 13
    isSurjection :: (Eq a, Eq b) => [(a,b)] -> [a] -> [b] -> Bool
    isSurjection fs xs ys = isFn fs xs ys && setEquality (uniqueList (allSnd fs)) ys

    -- Exercise 14
    isBijection :: (Eq a, Eq b) => [(a,b)] -> [a] -> [b] -> Bool
    isBijection fs xs ys = isInjection fs xs ys && isSurjection fs xs ys

    -- Pre-defined function sets (0-10) for testing
    f0 = [(1,2),(2,3),(3,4),(4,3)]
    x0 = [1..4]
    y0 = [1..4]

    f1 = [(1,'t'),(2,'h'),(3,'e'),(4,' '),(5,'w'),(6,'o'),(7,'r'),(8,'l'),(9,'d'),(10,' ')]
    x1 = [1..10]
    y1 = " abcdefghijklmnopqrstuvwxyz"

    f2 = [('l','t'),('o','h'),('v','e'),('e','i'),('i','m'),('n','p'),('t','o'),('h','r'),('e','t'),('t','a'),('i','n'),('m','c'),('e','e'),('o','o'),('f','f'),('c','b'),('h','e'),('o','i'),('l','n'),('e','g'),('r','e'),('a','a')]
    x2 = "vntimfcholera"
    y2 = "abcdefghijklmnopqrstuvwxyz"

    f3 = [(1,3),(3,7),(5,11),(7,15),(9,19),(11,23),(13,27),(15,31),(17,35),(19,39),(21,43),(23,47),(25,51),(27,55),(29,59),(31,63),(33,67),(35,71),(37,75),(39,79),(41,83),(43,87),(45,91),(47,95),(49,99)]
    x3 = [1,3..50]
    y3 = [3,7..100]

    f4 = [(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,1),(13,2),(1,3),(2,4),(3,5),(4,6),(5,7),(6,8),(7,9),(8,10),(9,11),(10,1),(11,2),(12,3),(13,4),(1,5),(2,6),(3,7),(4,8),(5,9),(6,10),(7,11),(8,1),(9,2),(10,3),(11,4),(12,5),(13,6),(1,7),(2,8),(3,9),(4,10),(5,11),(6,1),(7,2),(8,3),(9,4),(10,5),(11,6),(12,7),(13,8),(1,9),(2,10),(3,11),(4,1),(5,2),(6,3),(7,4),(8,5),(9,6),(10,7),(11,8),(12,9),(13,10),(1,11),(2,1),(3,2),(4,3),(5,4),(6,5),(7,6),(8,7),(9,8),(10,9),(11,10),(12,11),(13,1),(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10),(10,11),(11,1),(12,2),(13,3),(1,4),(2,5),(3,6),(4,7),(5,8),(6,9),(7,10),(8,11),(9,1)]
    x4 = [1..15]
    y4 = [1..100]

    f5 = [(1,1),(2,2),(3,3),(4,5),(5,8),(6,13),(7,21),(8,34),(9,55),(10,89),(11,144),(12,233),(13,377),(14,610),(15,987),(16,1597),(17,2584),(18,4181),(19,6765),(20,10946),(21,17711),(22,28657),(23,46368),(24,75025),(25,121393),(26,196418),(27,317811),(28,514229),(29,832040),(30,1346269)]
    x5 = [1..30]
    y5 = [1..1346270]

    f6 = [(-10,101),(-9,82),(-8,65),(-7,50),(-6,37),(-5,26),(-4,17),(-3,10),(-2,5),(-1,2),(0,1),(1,2),(2,5),(3,10),(4,17),(5,26),(6,37),(7,50),(8,65),(9,82),(10,101)]
    x6 = [-10..10]
    y6 = [1..101]

    f7 = [(0,0),(1,64),(2,61),(3,58),(4,55),(5,52),(6,49),(7,46),(8,43),(9,40),(10,37),(11,34),(12,31),(13,28),(14,25),(15,22),(16,19),(17,16),(18,13),(19,10),(20,7),(21,4),(22,1),(23,65),(24,62),(25,59),(26,56),(27,53),(28,50),(29,47),(30,44),(31,41),(32,38),(33,35),(34,32),(35,29),(36,26),(37,23),(38,20),(39,17),(40,14),(41,11),(42,8),(43,5),(44,2),(45,66),(46,63),(47,60),(48,57),(49,54),(50,51),(51,48),(52,45),(53,42),(54,39),(55,36),(56,33),(57,30),(58,27),(59,24),(60,21),(61,18),(62,15),(63,12),(64,9),(65,6),(66,3)]
    x7 = [0..66]
    y7 = [0..66]

    f8 = [(100,10),(99,9),(98,9),(97,9),(96,9),(95,9),(94,9),(93,9),(92,9),(91,9),(90,9),(89,9),(88,9),(87,9),(86,9),(85,9),(84,9),(83,9),(82,9),(81,9),(80,8),(79,8),(78,8),(77,8),(76,8),(75,8),(74,8),(73,8),(72,8),(71,8),(70,8),(69,8),(68,8),(67,8),(66,8),(65,8),(64,8),(63,7),(62,7),(61,7),(60,7),(59,7),(58,7),(57,7),(56,7),(55,7),(54,7),(53,7),(52,7),(51,7),(50,7),(49,7),(48,6),(47,6),(46,6),(45,6),(44,6),(43,6),(42,6),(41,6),(40,6),(39,6),(38,6),(37,6),(36,6),(35,5),(34,5),(33,5),(32,5),(31,5),(30,5),(29,5),(28,5),(27,5),(26,5),(25,5),(24,4),(23,4),(22,4),(21,4),(20,4),(19,4),(18,4),(17,4),(16,4),(15,3),(14,3),(13,3),(12,3),(11,3),(10,3),(9,3),(8,2),(7,2),(6,2),(5,2),(4,2),(3,1),(2,1),(1,1)]
    x8 = [1..100]
    y8 = [1..10]

    f9 = [(True, True), (False,False)]
    x9 = [True,False]
    y9 = [True, False]

    f10 = [('1',-37),('2',-36),('3',-35),('4',-34),('5',-33),('6',-32),('7',-31),('8',-30),('9',-29),(':',-28),(';',-27),('<',-26),('=',-25),('>',-24),('?',-23),('@',-22),('A',-21),('B',-20),('C',-19),('D',-18),('E',-17),('F',-16),('G',-15),('H',-14),('I',-13),('J',-12),('K',-11),('L',-10),('M',-9),('N',-8),('O',-7),('P',-6),('Q',-5),('R',-4),('S',-3),('T',-2),('U',-1),('V',0),('W',1),('X',2),('Y',3),('Z',4),('[',5),('\\',6),(']',7),('^',8),('_',9),('`',10),('a',11),('b',12),('c',13),('d',14),('e',15),('f',16),('g',17),('h',18),('i',19),('j',20),('k',21),('l',22),('m',23),('n',24),('o',25),('p',26),('q',27),('r',28),('s',29),('t',30),('u',31),('v',32),('w',33),('x',34),('y',35),('z',36)]
    x10 = ['1'..'z']
    y10 = [-37..37]
