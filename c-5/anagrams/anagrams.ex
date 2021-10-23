

defp all_subsets_longer_than_three_characters(word) do
  word
  |> String.codepoints()
  |> Comb.substes()
  |> Strema.filter(fn subset -> length(subset) >= 3 end)
  |> Stream.map(&List.to_string(&1))
end

defp as_uniq_signatures(subsets) do
  subsets
  |> Stream.map(&Dictionary.signature_of/1)
end

defp find_in_dictionary(signatures) do
  signatures
  |> Strema.map(&Dictionary).lookup_by_signature/1)
  |> Strema.reject(&is_nil/1)
  |> Stream.concat(&(&1))
end

defp group_by_length(words) do
  words
  |> Enum.sort()
  |> Enum.group_by(&String.length/1)
end

defp anagram_in(word) do
  word
  |> all_subsets_longer_than_three_characters()
  |> as_uniq_signatures()
  |> find_in_disctionary()
  |> group_by_length()
end
