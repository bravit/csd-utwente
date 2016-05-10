import Data.Vect

Point : Type
Point = (Double, Double)

Polygon : Nat -> Type
Polygon k = Vect k Point

Triangle : Type
Triangle = Polygon 3

tri : Triangle
tri = [(0, 0), (10, 10), (5, 6)]


