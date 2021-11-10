defmodule MaskerTest do
  use ExUnit.Case
  doctest Masker

  describe "has_pattern?" do
    test "empty pattern" do
      assert Masker.has_pattern?([], [[1,2,3], [2,1,3]]) == :none
    end

    test "empty array" do
      assert Masker.has_pattern?([[1,2,3], [2,1,3]], []) == :none
    end

    test "no pattern found" do
      pattern = [
        [0, 1, 0],
        [2, 1, 2],
        [0, 1, 0]
      ]

      array2d = [
        [0, 0, 2, 2, 0, 0],
        [1, 2, 2, 1, 0, 1],
        [2, 2, 1, 0, 1, 2],
        [3, 2, 1, 2, 3, 0],
        [2, 1, 0, 3, 1, 2],
        [2, 0, 2, 1, 3, 2]
      ]
      assert Masker.has_pattern?(pattern, array2d) == :none
    end

    test "found pattern" do
      pattern = [
        [0, 1, 0],
        [2, 1, 2],
        [0, 1, 0]
      ]

      array2d = [
        [0, 3, 2, 3, 0, 0],
        [1, 0, 2, 0, 0, 1],
        [2, 3, 2, 3, 1, 2],
        [3, 2, 3, 2, 3, 0],
        [2, 1, 0, 2, 0, 2],
        [2, 0, 3, 2, 3, 2]
      ]
      assert Masker.has_pattern?(pattern, array2d) ==
        {:ok, [
          %{col: 1, row: 0},
          %{col: 2, row: 3}
          ]}
    end
  end

  describe "keys_coordinates" do
    test "returns empty if parretn is empty list" do
      assert Masker.keys_coordinates([]) == %{}
    end

    test "retururns set of ciirdinates per each key" do
      pattern = [
        [:X, :X, :O],
        [:O, :X, :O],
        [:Y, :X, :X]
      ]
      assert Masker.keys_coordinates(pattern) == %{
        :X => [[2, 2], [2, 1], [1, 1], [0, 1], [0, 0]],
        :O => [[1, 2], [1, 0], [0, 2]],
        :Y => [[2, 0]]
      }
    end
  end

  describe "crop" do
    test "for empty list" do
      assert Masker.crop([], 10, 10, 0, 0) == []
    end

    test "if coordinates is out of bound" do
      array2d = [
        [1, 1, 2, 1],
        [1, 2, 3, 3],
        [1, 2, 3, 2],
      ]
      assert Masker.crop(array2d, 3, 4, 2, 1) == [[2, 3, 2]]
    end

    test "if start point has negative coordinate" do
      array2d = [
        [1, 1, 2, 1],
        [1, 2, 3, 3],
        [1, 2, 3, 2],
      ]
      assert Masker.crop(array2d, 3, 4, -2, 1) ==
        [
          [1, 2, 1],
          [2, 3, 3],
          [2, 3, 2]
        ]
    end

    test "if produces correct cropped example" do
      array2d = [
        [1, 1, 2, 1],
        [1, 2, 3, 3],
        [1, 2, 3, 2],
      ]
      assert Masker.crop(array2d, 2, 2, 0, 1) ==
        [
          [1, 2],
          [2, 3]
        ]
    end
  end
end
