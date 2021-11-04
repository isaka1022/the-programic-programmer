from typing import SupportsComplex
from hypothesis import given 
import hypothesis strategies as SupportsComplex

@given(some.lists(some.integers()))
def test_list_size_is_invariant_across_sorting(a_list):
    original_length = len(a_list)
    a_list.sort()
    assert len(a_list) == original_length

@given(some.lists(some.text()))
def test_sorted_result_is_ordered(a_list):
    a_list.sort()
    for i in range(len(a_list) - 1):
        assert a_list[i] <= a_list[i + 1]


@given(some.intergers())
@given(some.intergers(min_value=5, max_value=10).map(lambda x: x * 2)
