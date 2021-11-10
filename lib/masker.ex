defmodule Masker do
  @spec has_pattern?(list, list) :: :none | {:ok, [...]}
  def has_pattern?([], _), do: :none
  def has_pattern?(_, []), do: :none
  def has_pattern?(pattern, array2d) do
    %{height: p_height, width: p_width} =
      height_width(pattern)
    %{height: a_height, width: a_width} =
      height_width(array2d)

    if elements_length(pattern) <= elements_length(array2d) &&
      p_height <= a_height && p_width <= a_width do

      pattern_coordinates =
        pattern
        |> keys_coordinates
        |> Map.values
        |> Enum.sort
      pattern_coordinates_size = length(pattern_coordinates)

      results = 0..(a_height - p_height)
      |> Enum.map(fn row ->
        0..(a_width - p_width)
        |> Enum.map(fn col ->
          fragment_coordinates =
            crop(array2d, p_height, p_width, row, col)
            |> keys_coordinates
            |> Map.values
          if pattern_coordinates_size == length(fragment_coordinates) &&
            Enum.sort(fragment_coordinates) == pattern_coordinates do
            %{row: row, col: col}
          end
        end)
      end)
      |> List.flatten
      |> Enum.reject(&is_nil/1)
      case results do
        [] -> :none
        coordinates -> {:ok, coordinates}
      end
    else
      :none
    end
  end

  @spec crop(list, integer, integer, integer, integer) :: list
  def crop([], _, _, _, _), do: []
  def crop(_, height, width, _, _) when height <= 0 or width <= 0, do: []
  def crop(array2d, height, width, row, col) do
    {row, col} = {negative_to_zero(row), negative_to_zero(col)}
    %{
      height: scoped_height,
      width: scoped_width
    } =
      max_coord_within_bounds(array2d, height, width, row, col)

    row..(scoped_height - 1)
    |> Enum.map(fn row_index ->
      col..(scoped_width - 1)
      |> Enum.map(fn col_index ->
        array2d
        |> Enum.at(row_index)
        |> Enum.at(col_index)
      end)
    end)
  end

  defp max_coord_within_bounds(array2d, height, width, row, col) do
    %{height: ar_height, width: ar_width} = height_width(array2d)
    scoped_height = row + height
    scoped_width = col + width
    %{
      height: (if scoped_height <= ar_height, do: scoped_height, else: ar_height),
      width: (if scoped_width <= ar_width, do: scoped_width, else: ar_width)
    }
  end

  defp negative_to_zero(value), do: if value < 0, do: 0, else: value

  @spec keys_coordinates(list) :: %{any => list}
  def keys_coordinates(pattern) do
    pattern
    |> Enum.with_index
    |> Enum.reduce(%{}, fn {row, row_i}, acc_all ->
      row
      |> Enum.with_index
      |> Enum.reduce(acc_all, fn {element, col_i}, acc ->
        element_instr = case acc[element] do
          nil -> [[row_i, col_i]]
          existing -> [[row_i, col_i] | existing]
        end
        Map.put(acc, element, element_instr)
      end)
    end)
  end

  defp height_width(array2d) do
    %{
      height: length(array2d),
      width: length(Enum.at(array2d, 1))
    }
  end

  defp elements(matrix) do
    matrix
    |> Enum.flat_map(fn li -> Enum.uniq(li) end)
    |> Enum.uniq
  end

  defp elements_length(array2d) do
    array2d
    |> elements
    |> length
  end
end
